FROM debian:bullseye AS builder
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
RUN curl -fsSL https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz -o nginx.tar.gz && \
    tar -xzf nginx.tar.gz

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

# --- Final Stage ---
FROM debian:bullseye-slim

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Create nginx user and group with a safe shell
RUN groupadd -r nginx && useradd -r -g nginx -d /var/cache/nginx -s /usr/sbin/nologin nginx

# Copy NGINX from builder
COPY --from=builder /usr/local/nginx /usr/local/nginx

# Create cache and html dirs, set permissions
RUN mkdir -p /var/cache/nginx /usr/local/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx /usr/local/nginx

# Copy custom configuration and index page
COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY index.html /usr/local/nginx/html/index.html

EXPOSE 80 443

USER nginx

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s CMD curl -f http://localhost/ || exit 1

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
