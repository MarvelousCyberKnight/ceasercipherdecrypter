def caesar_decrypt(text, shift):
    """Decrypt text using Caesar cipher with given shift."""
    result = ""
    
    for char in text:
        if char.isalpha():
            # Determine if uppercase or lowercase
            start = ord('A') if char.isupper() else ord('a')
            # Shift character and wrap around alphabet
            shifted = chr((ord(char) - start - shift) % 26 + start)
            result += shifted
        else:
            # Keep non-alphabetic characters unchanged
            result += char
    
    return result


def try_all_shifts(encrypted_text):
    """Try all possible Caesar cipher shifts (0-25)."""
    print(f"\nEncrypted text: {encrypted_text}\n")
    print("All possible decryptions:\n")
    print("-" * 60)
    
    for shift in range(26):
        decrypted = caesar_decrypt(encrypted_text, shift)
        print(f"Shift {shift:2d}: {decrypted}")
    
    print("-" * 60)



print("=" * 60)
print("Caesar Cipher Decoder - All Possible Shifts")
print("=" * 60)
    
encrypted_text = input("\nEnter the encrypted text: ").strip()
    
if not encrypted_text:
    print("Error: Please enter some text to decrypt.")
    
try_all_shifts(encrypted_text)
print("\nLook through the results above to find the readable message!")
