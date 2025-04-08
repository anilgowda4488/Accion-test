import re

class LogProcessor:
    def __init__(self, file_path):
        """Initialize with the log file path."""
        self.file_path = file_path

    def extract_errors(self):
        """Extracts and formats ERROR messages from the log file."""
        errors = []
        with open(self.file_path, 'r') as file:
            for line in file:
                match = re.search(r'ERROR: (.+)', line)
                if match:
                    errors.append(f"ERROR: {match.group(1).upper()}")
        return errors

    def display_errors(self):
        """Prints extracted ERROR messages."""
        errors = self.extract_errors()
        if errors:
            print("\nExtracted ERROR Messages:")
            for error in errors:
                print(error)
        else:
            print("No ERROR messages found.")

# Example usage
if __name__ == "__main__":
    log_processor = LogProcessor("system.log")
    log_processor.display_errors()
