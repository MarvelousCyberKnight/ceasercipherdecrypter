# Caesar Cipher Decrypter

A smart Python tool that automatically decrypts Caesar cipher text without requiring you to know the shift key. It analyzes all possible shifts and uses statistical frequency analysis to predict the most likely decryption.

## Overview

This decrypter works by testing all 26 possible shift values and scoring each result against the expected frequency distribution of letters in English text. The shift that produces text closest to natural English is selected as the correct decryption.

## How It Works

The tool employs a chi-square statistical test to compare letter frequencies in the decrypted text against known English language letter frequencies. Lower chi-square scores indicate a better match with natural English, helping identify the correct shift key automatically.

**Key Features:**
- Automatic shift detection (tests all 26 possible shifts)
- Statistical frequency analysis using chi-square scoring
- Preserves capitalization and non-alphabetic characters
- No prior knowledge of the shift key required

## Usage

Simply run the script and enter your encrypted text when prompted:

```python
python caesar_decrypt.py
```

**Example:**

```
Enter your cipher text: Khoor Zruog
Detected shift: 3
Decrypted text: Hello World
```

## Technical Details

**Frequency Analysis:** The decrypter uses standard English letter frequency distributions where E, T, A, O, and I are the most common letters. By comparing the letter distribution in each decryption attempt against these expected frequencies, it calculates a chi-square score.

**Chi-Square Test:** For each possible shift (0-25), the algorithm:
1. Decrypts the ciphertext using that shift
2. Counts the frequency of each letter
3. Compares observed frequencies to expected English frequencies
4. Calculates a chi-square statistic
5. Selects the shift with the lowest chi-square value

## Requirements

- Python 3.x
- Standard library only (no external dependencies)

## Limitations

- Works best with longer text samples (more data = better accuracy)
- Optimized for English language text only
- May struggle with very short messages or text with unusual letter distributions
- Cannot decrypt texts using multiple shift keys or other cipher methods

## Code Structure

- `ENGLISH_FREQ`: Dictionary containing standard English letter frequency percentages
- `decrypt_with_shift()`: Applies a Caesar shift decryption with a given key
- `chi_square_score()`: Calculates statistical score for decrypted text
- `smart_caesar_decrypt()`: Tests all shifts and returns the best result

## License

This project is open source and available for educational and personal use.

## Contributing

Feel free to fork this project and submit improvements. Potential enhancements could include support for other languages, handling of multiple cipher types, or a graphical user interface.

---

**Note:** This tool is intended for educational purposes and demonstrates basic cryptanalysis techniques. Caesar ciphers are not secure for protecting sensitive information.
