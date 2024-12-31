# XOR Cipher in Assembly

## Overview
This project implements a simple **XOR Cipher** in x86-64 assembly language. The program allows encryption and decryption of files using a user-provided key. While XOR ciphers are not secure by modern standards, they are a foundational concept in cryptography and are often used in cybersecurity tasks like malware analysis and binary obfuscation.

---

## Features
1. **Symmetric Encryption/Decryption**:
   - The same key is used for both encryption and decryption.
2. **File Handling**:
   - Encrypts the content of a file and saves the result as `encrypted.txt`.
   - Decrypts an encrypted file and saves the result as `decrypted.txt`.
3. **Command-Line Arguments**:
   - Specify the mode (`-e` for encryption or `-d` for decryption), the file to process, and the encryption key.

---

## How It Works
1. **Encryption**:
   - Each byte of the file content is XORed with a corresponding byte of the key.
   - If the key is shorter than the file content, it wraps around (repeats).
2. **Decryption**:
   - XORing the encrypted content with the same key restores the original data (XOR is symmetric).
3. **Key Management**:
   - The key is provided as a command-line argument.

---

## Usage

### **Syntax**
```bash
./xor_cipher <-e|-d> <file> <key>
