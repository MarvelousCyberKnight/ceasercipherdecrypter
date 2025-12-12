# Caesar Cipher Decrypter

A smart cryptanalysis tool available in both Python and Bash that automatically decrypts Caesar cipher text without requiring you to know the shift key. It analyzes all possible shifts and uses statistical frequency analysis to predict the most likely decryption.

## Overview

This decrypter works by testing all 26 possible shift values and scoring each result against the expected frequency distribution of letters in English text. The shift that produces text closest to natural English is selected as the correct decryption.

The tool is available in two implementations:
- **Python version** (`caesar_decrypt.py`) - Ideal for cross-platform use with clean, readable code
- **Bash version** (`caesar_decrypt.sh`) - Perfect for Unix/Linux environments and shell scripting workflows

## How It Works

The tool employs a chi-square statistical test to compare letter frequencies in the decrypted text against known English language letter frequencies. Lower chi-square scores indicate a better match with natural English, helping identify the correct shift key automatically.

**Key Features:**
- Automatic shift detection (tests all 26 possible shifts)
- Statistical frequency analysis using chi-square scoring
- Preserves capitalization and non-alphabetic characters
- No prior knowledge of the shift key required

## Usage

### Python Version

Simply run the script and enter your encrypted text when prompted:

```bash
python caesar_decrypt.py
```

**Example:**

```
Enter your cipher text: Khoor Zruog
Detected shift: 3
Decrypted text: Hello World
```

### Bash Version

Make the script executable and run it:

```bash
chmod +x caesar_decrypt.sh
./caesar_decrypt.sh
```

**Example:**

```
Enter your cipher text: Khoor Zruog
Detected shift: 3
Decrypted text: Hello World
```

Both versions produce identical results and use the same underlying algorithm.

## Technical Details

**Frequency Analysis:** The decrypter uses standard English letter frequency distributions where E, T, A, O, and I are the most common letters. By comparing the letter distribution in each decryption attempt against these expected frequencies, it calculates a chi-square score.

**Chi-Square Test:** For each possible shift (0-25), the algorithm:
1. Decrypts the ciphertext using that shift
2. Counts the frequency of each letter
3. Compares observed frequencies to expected English frequencies
4. Calculates a chi-square statistic
5. Selects the shift with the lowest chi-square value

## Requirements

### Python Version
- Python 3.x
- Standard library only (no external dependencies)

### Bash Version
- Bash 4.0 or higher (for associative arrays)
- Standard Unix utilities (tr, printf)
- Works on Linux, macOS, and WSL (Windows Subsystem for Linux)

## Limitations

- Works best with longer text samples (more data = better accuracy)
- Optimized for English language text only
- May struggle with very short messages or text with unusual letter distributions
- Cannot decrypt texts using multiple shift keys or other cipher methods

## Code Structure

### Python Version (`caesar_decrypt.py`)
- `ENGLISH_FREQ`: Dictionary containing standard English letter frequency percentages
- `decrypt_with_shift()`: Applies a Caesar shift decryption with a given key
- `chi_square_score()`: Calculates statistical score for decrypted text
- `smart_caesar_decrypt()`: Tests all shifts and returns the best result

### Bash Version (`caesar_decrypt.sh`)
- `ENGLISH_FREQ`: Associative array with English letter frequencies (scaled by 1000 for integer arithmetic)
- `decrypt_with_shift()`: Performs Caesar shift decryption using ASCII manipulation
- `chi_square_score()`: Computes chi-square statistic using integer-only math
- `smart_caesar_decrypt()`: Iterates through all shifts and identifies the optimal decryption

**Implementation Note:** The Bash version uses integer arithmetic throughout (scaling frequencies by 1000) to avoid floating-point operations, making it efficient while maintaining accuracy.

## License

This project is open source and available for educational and personal use.

## Contributing

Feel free to fork this project and submit improvements. Potential enhancements could include support for other languages, handling of multiple cipher types, or a graphical user interface.

---

**Note:** This tool is intended for educational purposes and demonstrates basic cryptanalysis techniques. Caesar ciphers are not secure for protecting sensitive information.
