class EvenFibonacciSum:
    """Class to calculate the sum of the first N even Fibonacci numbers."""
    
    def __init__(self, count):
        """Initialize with the number of even Fibonacci numbers to sum."""
        self.count = count

    def sum_even_fibonacci(self):
        """Calculates the sum of the first N even Fibonacci numbers."""
        even_fib_sum = 0
        a, b = 2, 8  # First two even Fibonacci numbers
        count = 0

        while count < self.count:
            even_fib_sum += a
            a, b = b, 4 * b + a  # Efficient formula for even Fibonacci numbers
            count += 1
        
        return even_fib_sum

# Example usage
if __name__ == "__main__":
    fibonacci_calculator = EvenFibonacciSum(100)
    result = fibonacci_calculator.sum_even_fibonacci()
    print(f"Sum of the first 100 even Fibonacci numbers: {result}")
