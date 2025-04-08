class CommonElementsFinder:
    """Class to find common elements between two sorted arrays without duplicates."""

    def __init__(self, arr1, arr2):
        """Initialize with two sorted arrays."""
        self.arr1 = arr1
        self.arr2 = arr2

    def find_common_elements(self):
        """Returns an array containing common elements without duplicates."""
        i, j = 0, 0
        common_elements = []

        while i < len(self.arr1) and j < len(self.arr2):
            if self.arr1[i] == self.arr2[j]:  
                if not common_elements or common_elements[-1] != self.arr1[i]:  # Avoid duplicates
                    common_elements.append(self.arr1[i])
                i += 1
                j += 1
            elif self.arr1[i] < self.arr2[j]:
                i += 1
            else:
                j += 1
        
        return common_elements

# Example usage
if __name__ == "__main__":
    arr1 = [1, 2, 4, 4, 5, 6, 8, 10]
    arr2 = [2, 4, 4, 6, 8, 9, 10, 12]

    finder = CommonElementsFinder(arr1, arr2)
    result = finder.find_common_elements()
    print(f"Common elements: {result}")
