import string

ENGLISH_FREQ = {
    'A': 8.167, 'B': 1.492, 'C': 2.782, 'D': 4.253, 'E': 12.702,
    'F': 2.228, 'G': 2.015, 'H': 6.094, 'I': 6.966, 'J': 0.153,
    'K': 0.772, 'L': 4.025, 'M': 2.406, 'N': 6.749, 'O': 7.507,
    'P': 1.929, 'Q': 0.095, 'R': 5.987, 'S': 6.327, 'T': 9.056,
    'U': 2.758, 'V': 0.978, 'W': 2.360, 'X': 0.150, 'Y': 1.974,
    'Z': 0.074
}

def decrypt_with_shift(ciphertext, shift):
    result = ""
    for char in ciphertext:
        if char.isalpha():
            offset = 65 if char.isupper() else 97
            result += chr((ord(char) - offset - shift) % 26 + offset)
        else:
            result += char
    return result

def chi_square_score(text):

    freq = {letter: 0 for letter in string.ascii_uppercase}
    total_letters = 0

    for char in text.upper():
        if char in freq:
            freq[char] += 1
            total_letters += 1

    if total_letters == 0:
        return float("inf")

    chi_sq = 0.0
    for letter in string.ascii_uppercase:
        observed = freq[letter]
        expected = ENGLISH_FREQ[letter] * total_letters / 100
        chi_sq += (observed - expected) ** 2 / expected

    return chi_sq

def smart_caesar_decrypt(ciphertext):
    best_shift = None
    best_score = float("inf")
    best_plaintext = ""

    for shift in range(26):
        candidate = decrypt_with_shift(ciphertext, shift)
        score = chi_square_score(candidate)

        if score < best_score:
            best_score = score
            best_shift = shift
            best_plaintext = candidate

    return best_shift, best_plaintext


cipher = input("Enter your cipher text:")
shift, plaintext = smart_caesar_decrypt(cipher)

print("Detected shift:", shift)
print("Decrypted text:", plaintext)
