# Stage 1: Builder Stage
FROM debian:bullseye AS builder

# Install dependencies for building NGINX
RUN apt-get update && apt-get install -y \
    build-essential \
    libpcre3 \
    libpcre3-dev \
    zlib1g \
    zlib1g-dev \
    libssl-dev \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

ENV NGINX_VERSION=1.19.10

WORKDIR /usr/src/nginx
RUN curl -fsSL https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar -xz

WORKDIR /usr/src/nginx/nginx-${NGINX_VERSION}
RUN ./configure \
    --prefix=/usr/local/nginx \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_gzip_static_module \
    --with-stream \
    --with-pcre \
    && make -j$(nproc) \
    && make install

---

FROM debian:bullseye-slim

# Creating nginx user and group
RUN groupadd -r nginx && useradd -r -g nginx -d /var/cache/nginx -s /sbin/nologin nginx

# Copy NGINX from builder
COPY --from=builder /usr/local/nginx /usr/local/nginx

# Creating cache and html dirs, setting permissions
RUN mkdir -p /var/cache/nginx /usr/local/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx /usr/local/nginx

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY index.html /usr/local/nginx/html/index.html

EXPOSE 80 443
USER nginx

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s CMD curl -f http://localhost/ || exit 1
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
