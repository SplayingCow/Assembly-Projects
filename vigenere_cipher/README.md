# Vigenère Cipher in Assembly

## Overview
This project implements the **Vigenère Cipher**, a classic polyalphabetic encryption technique, using **x86-64 assembly language**. The Vigenère Cipher enhances substitution ciphers by using a repeating keyword to determine letter shifts, making it more resistant to frequency analysis compared to monoalphabetic ciphers.

This program provides functionality to:
1. **Encrypt** a plaintext file using a keyword.
2. **Decrypt** a ciphertext file back to plaintext using the same keyword.

---

## Features
- **Keyword-Based Encryption**:
  - Encrypts text by shifting letters based on a repeating keyword.
- **Decryption**:
  - Reverses the encryption process to recover the original plaintext.
- **Input and Output**:
  - Reads input from a file and saves the result to `encrypted.txt` or `decrypted.txt`.

---

## How the Vigenère Cipher Works

### 1. **Keyword**
   - The user provides a keyword (e.g., `KEY`) that determines the shifting values for encryption or decryption.
   - Each letter of the keyword is mapped to a number (`A=0`, `B=1`, ..., `Z=25`).

### 2. **Encryption**
   - Each letter in the plaintext is shifted forward in the alphabet by the value of the corresponding letter in the keyword.
   - The keyword repeats if the plaintext is longer than the keyword.

   **Example**:
