#!/bin/bash

# English letter frequency percentages (scaled by 1000 to avoid decimals)
declare -A ENGLISH_FREQ=(
    [A]=8167 [B]=1492 [C]=2782 [D]=4253 [E]=12702
    [F]=2228 [G]=2015 [H]=6094 [I]=6966 [J]=153
    [K]=772 [L]=4025 [M]=2406 [N]=6749 [O]=7507
    [P]=1929 [Q]=95 [R]=5987 [S]=6327 [T]=9056
    [U]=2758 [V]=978 [W]=2360 [X]=150 [Y]=1974
    [Z]=74
)

# Decrypt with a given shift
decrypt_with_shift() {
    local text="$1"
    local shift=$2
    local result=""
    local i char ascii offset new_ascii
    
    for ((i=0; i<${#text}; i++)); do
        char="${text:$i:1}"
        
        if [[ "$char" =~ [A-Za-z] ]]; then
            ascii=$(printf "%d" "'$char")
            
            if [[ "$char" =~ [A-Z] ]]; then
                offset=65
            else
                offset=97
            fi
            
            new_ascii=$(( (ascii - offset - shift + 26) % 26 + offset ))
            result+=$(printf "\\$(printf '%03o' "$new_ascii")")
        else
            result+="$char"
        fi
    done
    
    echo "$result"
}

# Calculate chi-square score (using integer arithmetic)
chi_square_score() {
    local text="$1"
    local upper_text=$(echo "$text" | tr '[:lower:]' '[:upper:]')
    
    # Count letter frequencies
    declare -A freq
    local total_letters=0
    local i char
    
    for letter in {A..Z}; do
        freq[$letter]=0
    done
    
    for ((i=0; i<${#upper_text}; i++)); do
        char="${upper_text:$i:1}"
        if [[ "$char" =~ [A-Z] ]]; then
            ((freq[$char]++))
            ((total_letters++))
        fi
    done
    
    if [ $total_letters -eq 0 ]; then
        echo "999999999"
        return
    fi
    
    # Calculate chi-square using integer arithmetic (scaled by 1000000)
    local chi_sq=0
    local letter observed expected diff squared_diff
    
    for letter in {A..Z}; do
        observed=${freq[$letter]}
        # Scale observed by 1000 for precision
        observed=$((observed * 1000))
        
        # expected = ENGLISH_FREQ[letter] * total_letters / 100
        expected=$((${ENGLISH_FREQ[$letter]} * total_letters / 100))
        
        if [ $expected -gt 0 ]; then
            diff=$((observed - expected))
            squared_diff=$((diff * diff))
            # chi_sq += squared_diff / expected
            chi_sq=$((chi_sq + squared_diff / expected))
        fi
    done
    
    echo "$chi_sq"
}

# Main decryption function
smart_caesar_decrypt() {
    local ciphertext="$1"
    local best_shift=-1
    local best_score=999999999
    local best_plaintext=""
    
    for shift in {0..25}; do
        candidate=$(decrypt_with_shift "$ciphertext" $shift)
        score=$(chi_square_score "$candidate")
        
        if [ $score -lt $best_score ]; then
            best_score=$score
            best_shift=$shift
            best_plaintext="$candidate"
        fi
    done
    
    echo "$best_shift"
    echo "$best_plaintext"
}

# Main program
echo -n "Enter your cipher text: "
read cipher

result=($(smart_caesar_decrypt "$cipher"))
shift_value=${result[0]}
plaintext="${result[@]:1}"

echo "Detected shift: $shift_value"
echo "Decrypted text: $plaintext"
