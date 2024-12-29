section .data
    filename db "output.txt", 0             ; File name 
    message db "Hello, this is Assembly!", 0
    success_msg db "File written and read successfully!", 0
    newline db 10,0                         ; Newline character

section .bss
    buffer resb 128                         ; Buffer for file content

section .text
    global _start

_start:
    ; Create and open the file for writing
    mov rax, 2                              ; syscall: open
    mov rdi, filename                       ; File name
    mov rsi, 0x41                           ; Flags: O_Creat | O_WRONLY
    mov rdx, 0o644                          ; Permissions: rw-r--r--
    syscall
    mov r12, rax                            ; Store the file descriptor in r12

    ; Write the message to the file
    mov rax, 1                              ; syscall: write
    mov rdi, r12                            ; File descriptor
    mov rsi, message                        ; Address of the message
    mov rdx, 25                             ; Length of the messaage
    syscall

    ; Close the file
    mov rax, 3                              ; syscall: close
    mov rdi, r12                            ; File descriptor
    syscall

    ; Open the file for reading
    mov rax, 2                              ; syscall: open
    mov rdi, filename                       ; File nama
    mov rsi, 0                              ; Flags: O_RDONLY
    syscall
    mov r12, rax                            ; Store the file descriptor in r12

    ; Read the file contents
    mov rax, 0                              ; syscall: read
    mov rdi, r12                            ; File descriptor
    mov rsi, buffer                         ; Address of the buffer
    mov rdx, 128                            ; Maximum bytes to read
    syscall

    ; Close the file
    mov rax, 3                              ; syscall: close
    mov rdi, r12                            ; File descriptor
    syscall

    ; Display the file contents
    mov rax, 1                              ; syscall: write
    mov rdi, 1                              ; File descriptor: stdout
    mov rsi, buffer                         ; Address of the buffer
    mov rdx, rax                            ; Number of bytes
    syscall

    ; Display success message
    mov rax, 1                              ; syscall: write
    mov rdi, 1                              ; File descriptor: stdout
    mov rsi, success_msg                    ; Address of success_msg
    mov rdx, 34                             ; Length of success_msg
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1 
    syscall 

    ; Exit the program 
    mov rax, 60                             ; syscall: exit
    xor rdi, rdi                            ; Exit code: 0
    syscall
