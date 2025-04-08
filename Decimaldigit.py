class PatternSumCalculator:
    """Class to calculate the sum of X + XX + XXX + XXXX for a given single digit X."""
    
    def __init__(self, digit):
        """Initialize with a single decimal digit."""
        if not isinstance(digit, int) or digit < 0 or digit > 9:
            raise ValueError("Input must be a single digit between 0 and 9.")
        self.digit = digit

    def calculate_sum(self):
        """Computes the sum X + XX + XXX + XXXX."""
        terms = [int(str(self.digit) * i) for i in range(1, 5)]  # Creates [X, XX, XXX, XXXX]
        return sum(terms)

# Example usage
if __name__ == "__main__":
    try:
        x = 3  # Example input
        calculator = PatternSumCalculator(x)
        result = calculator.calculate_sum()
        print(f"Result for X={x}: {result}")
    except ValueError as e:
        print(f"Error: {e}")
