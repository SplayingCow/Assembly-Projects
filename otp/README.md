# One-Time Pad (OTP) Encryption in Assembly

## Overview
This project implements the **One-Time Pad (OTP)** encryption algorithm using **x86-64 assembly language**. The OTP is a cryptographic technique that uses a random key of the same length as the plaintext to encrypt and decrypt data securely. It is theoretically unbreakable when used correctly.

This program provides functionality to:
1. **Encrypt** plaintext files using a randomly generated key.
2. **Decrypt** ciphertext files back into plaintext using the same key.

---

## Features
- **Random Key Generation**:
  - Generates a random key matching the length of the plaintext.
- **XOR-Based Encryption**:
  - Encrypts and decrypts data using the XOR operation.
- **File Handling**:
  - Reads plaintext/ciphertext from files and writes the results to output files.

---

## How the One-Time Pad Works

### **1. Key Generation**
- A random key is generated that is the same length as the plaintext.
- The key is stored in a separate file (`key.txt`) for later decryption.

### **2. Encryption**
- Each character of the plaintext is XORed with the corresponding character of the key.
- The result is the ciphertext.
- **Formula**: `Ciphertext[i] = Plaintext[i] XOR Key[i]`

### **3. Decryption**
- The ciphertext is XORed with the key to recover the plaintext.
- **Formula**: `Plaintext[i] = Ciphertext[i] XOR Key[i]`

---

## Program Usage

### **Syntax**
```bash
./otp <mode> <file>
