# README: String Reversal Program in Assembly (NASM)

## Overview
This project demonstrates how to reverse a string entered by the user using assembly language (NASM). It involves taking input from the user, calculating the string's length, reversing the string, and displaying the result. This program is a great exercise in handling strings and implementing basic logic in low-level assembly.

---

## Key Learnings

### 1. **Reading Input from the User**
   - Input is read using the `read` syscall (number `0`), which allows reading data from the terminal into a buffer.
   - Example:
     ```asm
     mov rax, 0          ; syscall: read
     mov rdi, 0          ; file descriptor: stdin
     mov rsi, input      ; address of the input buffer
     mov rdx, 128        ; maximum input length
     syscall
     ```
   - The input is stored in the `input` buffer for further processing.

---

### 2. **Calculating the String Length**
   - The program calculates the string length by iterating through each character in the input buffer until a newline (`\n`) or null terminator (`\0`) is encountered.
   - Example:
     ```asm
     mov rsi, input      ; rsi points to the start of the string
     xor rcx, rcx        ; rcx is used as the length counter

     strlen_loop:
         cmp byte [rsi], 10  ; Check for newline character
         je reverse_string   ; Stop if newline is found
         cmp byte [rsi], 0   ; Check for null terminator
         je reverse_string   ; Stop if null is found
         inc rsi             ; Move to the next character
         inc rcx             ; Increment length counter
         jmp strlen_loop
     ```

---

### 3. **Reversing the String**
   - The program uses two pointers: one starting at the end of the input string (`rsi`) and another at the beginning of the `reversed` buffer (`rdi`).
   - Characters are copied from the input string to the reversed buffer in reverse order.
   - Example:
     ```asm
     reverse_string:
         mov rsi, input      ; rsi points to the start of the input string
         mov rdi, reversed   ; rdi points to the start of the reversed buffer
         add rsi, rcx        ; Move rsi to the end of the string
         dec rsi             ; Adjust to point to the last character

     reverse_loop:
         cmp rcx, 0          ; Check if all characters are processed
         je print_result     ; If yes, jump to printing
         mov al, [rsi]       ; Load the character from the input
         mov [rdi], al       ; Store it in the reversed buffer
         dec rsi             ; Move to the previous character in input
         inc rdi             ; Move to the next character in reversed buffer
         dec rcx             ; Decrement length counter
         jmp reverse_loop
     ```

---

### 4. **Printing the Result**
   - The reversed string and a result message are printed using the `write` syscall (number `1`).
   - Example:
     ```asm
     mov rax, 1          ; syscall: write
     mov rdi, 1          ; file descriptor: stdout
     mov rsi, result_msg ; address of the result message
     mov rdx, 17         ; length of the message
     syscall

     mov rsi, reversed   ; address of the reversed string
     mov rdx, 128        ; max length of the reversed string
     syscall
     ```

---

### 5. **Exiting the Program**
   - The program terminates using the `exit` syscall (number `60`), returning a success code of `0`.
   - Example:
     ```asm
     mov rax, 60         ; syscall: exit
     xor rdi, rdi        ; exit code: 0
     syscall
     ```

---

## Challenges Faced
- Handling edge cases such as empty strings or input longer than the buffer size.
- Understanding the string manipulation logic, particularly managing pointers for reversing.

---

## Tools and Technologies Used
- **NASM**: For assembling the assembly code.
- **ld**: For linking the object file into an executable.
- **Linux syscall interface**: For performing input, output, and program exit.

---

## Assembly Workflow

1. **Write the Assembly Code**:
   - Save the code in a `.asm` file (e.g., `reverse.asm`).

2. **Assemble the Code**:
   ```bash
   nasm -f elf64 reverse.asm -o reverse.o
   ```

3. **Link the Object File**:
   ```bash
   ld reverse.o -o reverse
   ```

4. **Run the Program**:
   ```bash
   ./reverse
   ```

---

## Insights
- Assembly programming requires meticulous attention to detail, particularly in managing memory and registers.
- This project enhanced my understanding of string processing, pointer manipulation, and system calls at the low level.

---

## Conclusion
This string reversal program is a practical demonstration of assembly language's power and complexity. It offers valuable insights into how high-level language constructs like string operations are implemented at the hardware level.