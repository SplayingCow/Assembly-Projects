# Substitution Cipher with Frequency Analysis

## Overview
This project implements a **Substitution Cipher** in x86-64 assembly, providing functionalities to:
1. **Encrypt**: Transform plaintext into ciphertext using a custom substitution key.
2. **Decrypt**: Reverse the transformation to recover the original plaintext.
3. **Analyze**: Perform frequency analysis on ciphertext to identify letter frequency distributions.

Substitution ciphers are one of the simplest forms of encryption and are often used to demonstrate cryptography basics and cryptanalysis techniques.

---

## Features
- **Custom Encryption Key**:
  - Users provide a 26-character substitution key that maps each letter of the alphabet to another letter.
- **Encryption and Decryption**:
  - Encrypt a plaintext file and save the result to `encrypted.txt`.
  - Decrypt a ciphertext file back to plaintext and save it to `decrypted.txt`.
- **Frequency Analysis**:
  - Analyze the frequency of letters in a ciphertext to identify patterns.

---

## Usage

### **Syntax**
```bash
./substitution_cipher <mode> <file> <key>
