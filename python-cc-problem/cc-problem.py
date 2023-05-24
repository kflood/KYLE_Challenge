# Author kflood
# Checks the validity of supplied credit card numbers based on parameters:
# It must start with a 4, 5, or 6.
# It must contain exactly 16 digits.
# It must only consist of digits (0-9).
# It may have digits in groups of 4, separated by one hyphen "-".
# It must NOT use any other separator like ' ' , '_', etc.
# It must NOT have 4 or more consecutive repeated digits.

import re

def main():

    # Get inputs
    card_quantity = int(input("Input card quantity then list of cards: ").strip())
    
    for _ in range(card_quantity):
        cc_number = input().strip()
        if is_valid(cc_number):
            print("Valid")
        else:
            print("Invalid")

# Checks for validity according to listed parameters
def is_valid(cc_number):
    
    if not re.match(r'^[456]', cc_number):
        # Checks if cc_number doesn't start with 4,5, or 6
        return False
    elif not re.match(r'(?=(?:\d{16})|(?:\d{4}-\d{4}-\d{4}-\d{4}))', cc_number):
        # Checks if number doesn't have exactly 16 digits, or groupings of 4 with single hyphen separators
        # Also checks for bad separators or non-numerical characters
        return False
    
    # Check if number has any digits repeated 4 times
    cc_number = cc_number.replace('-', '')
    if re.search(r'(\d)\1{3}', cc_number):
        return False

    return True

main()

