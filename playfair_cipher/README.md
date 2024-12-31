# Playfair Cipher in Assembly

## Overview
This project implements the **Playfair Cipher**, a digraph substitution cipher that operates on pairs of letters using a 5x5 key square. Written in **x86-64 assembly language**, this program provides functionality to:
1. **Encrypt** plaintext files into ciphertext.
2. **Decrypt** ciphertext files back into plaintext.

The Playfair Cipher is an excellent example of historical cryptography and demonstrates multi-character substitution techniques.

---

## Features
- **Keyword-Based Key Square**:
  - Generates a 5x5 grid from a user-provided keyword for encryption and decryption.
- **Digraph-Based Processing**:
  - Operates on pairs of letters (digraphs) instead of individual characters.
- **Encryption and Decryption**:
  - Applies Playfair cipher rules to encrypt or decrypt text.

---

## How the Playfair Cipher Works

### **1. Key Square**
The 5x5 key square is generated from the keyword:
- The keyword is inserted into the grid, removing duplicates.
- The remaining letters of the alphabet (excluding `J`) fill the grid.
- Example with the keyword `KEYWORD`:

K E Y W O R D A B C F G H I L M N P Q S T U V X Z


### **2. Encryption Rules**
The plaintext is divided into pairs of letters (digraphs):
1. If a pair contains the same letter, a filler (`X`) is inserted.
 - Example: `HELLO` → `HE LX LO`
2. Each digraph is encrypted based on its position in the grid:
 - **Same Row**: Replace each letter with the letter to its right.
   - Example: `HE` → `EK`
 - **Same Column**: Replace each letter with the letter below it.
   - Example: `DM` → `RM`
 - **Rectangle**: Swap the corners of the rectangle formed by the two letters.
   - Example: `LO` → `CN`

### **3. Decryption Rules**
The ciphertext is decrypted by reversing the encryption rules:
1. **Same Row**: Replace each letter with the letter to its left.
2. **Same Column**: Replace each letter with the letter above.
3. **Rectangle**: Swap the corners back to their original positions.

---

## Program Usage

### **Syntax**
```bash
./playfair_cipher <mode> <file> <keyword>

