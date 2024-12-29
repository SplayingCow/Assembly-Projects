# README: Simple Calculator in Assembly (NASM)

## Overview
This project implements a basic calculator in assembly language using NASM. The program takes two numbers and an arithmetic operator (+, -, *, /) as inputs and computes the result. It is an exercise in handling user input, processing data, and implementing logic in assembly.

---

## Key Learnings

### 1. **Working with Input and Output**
   - **Syscall `write` (1)**: Used to display prompts and messages to the user.
   - **Syscall `read` (0)**: Used to read user input from the terminal.
   - Example:
     - Writing a message:
       ```asm
       mov rax, 1       ; Syscall: write
       mov rdi, 1       ; File descriptor: stdout
       mov rsi, prompt1 ; Address of the prompt message
       mov rdx, 23      ; Length of the prompt message
       syscall
       ```
     - Reading user input:
       ```asm
       mov rax, 0       ; Syscall: read
       mov rdi, 0       ; File descriptor: stdin
       mov rsi, num1    ; Address of the input buffer
       mov rdx, 4       ; Maximum number of bytes to read
       syscall
       ```

---

### 2. **Converting ASCII to Integers**
   - User input from the terminal is received as ASCII characters, so it needs to be converted to integers for arithmetic operations.
   - Example:
     - Converting a single ASCII digit to an integer:
       ```asm
       movzx rax, byte [num1] ; Load ASCII character
       sub rax, '0'           ; Convert to integer
       ```

---

### 3. **Handling Arithmetic Operations**
   - The program compares the input operator with specific characters (`+`, `-`, `*`, `/`) to determine the operation to perform.
   - Example:
     ```asm
     mov al, byte [operator]
     cmp al, '+'
     je add         ; Jump to addition code if operator is '+'
     cmp al, '-'
     je subtract    ; Jump to subtraction code if operator is '-'
     ```
   - Arithmetic operations:
     - **Addition**:
       ```asm
       add rax, rcx
       ```
     - **Subtraction**:
       ```asm
       sub rax, rcx
       ```
     - **Multiplication**:
       ```asm
       imul rax, rcx
       ```
     - **Division**:
       ```asm
       xor rdx, rdx ; Clear rdx for division
       div rcx
       ```

---

### 4. **Converting Result to ASCII**
   - After performing the arithmetic operation, the result is converted back to an ASCII character for display.
   - Example:
     ```asm
     add rax, '0'   ; Convert integer to ASCII
     mov [result], al
     ```

---

### 5. **Error Handling**
   - While the program doesn't include robust error handling, such as division by zero or invalid inputs, the structure allows easy extension to include these features.

---

## Challenges Faced
- Understanding how to read and process user input from the terminal.
- Working with ASCII conversion for arithmetic operations.
- Debugging logic errors in comparing and branching operations.

---

## Tools and Technologies Used
- **NASM**: For assembling the assembly code.
- **ld**: For linking the object file into an executable.
- **Linux syscall interface**: For interacting with the operating system.

---

## Assembly Workflow

1. **Write the Assembly Code**:
   - Write the `.asm` file with the logic for input, processing, and output.

2. **Assemble the Code**:
   ```bash
   nasm -f elf64 calculator.asm -o calculator.o
   ```

3. **Link the Object File**:
   ```bash
   ld calculator.o -o calculator
   ```

4. **Run the Program**:
   ```bash
   ./calculator
   ```

---

## Insights
- This project deepened understanding of how low-level programming works, from reading input to performing logic operations and outputting results.
- Learned the importance of handling system calls and managing CPU registers efficiently.

---

## Conclusion
This calculator program demonstrates the foundational principles of assembly programming. It highlights the importance of managing data manually and provides a deeper appreciation for higher-level programming abstractions.