section .data
    prompt1 db "Enter the first number: ",0
    prompt2 db "Enter the second number: ",0
    prompt_op db "Enter operation (+, -, *, /): ", 0
    result_msg db "The result is: ", 0
    newline db 10, 0

    buffer1 db 0        ; Buffer for first number
    buffer2 db 0        ; Buffer for second number
    operator db 0       ; Buffer for operator
    result db 0         ; Buffer for result

section .bss
    num1 resb 4         ; Reserve space for first number
    num2 resb 4         ; Reserve space for second number

section .text
    global _start

_start:
    ; Prompt and read first number
    mov rax, 1          ;syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, prompt1    ; address of prompt1
    mov rdx, 23         ; length of prompt1
    syscall

    mov rax, 0          ; syscall: read
    mov rdi, 0          ; file descriptor: stdin
    mov rsi, num1       address of buffer
    mov rdx, 4          ; read up to 4 bytes
    syscall

    ; Convert first number from ASCII
    movzx rax, byte [num1]      ; Load first character from num1
    sub rax, '0'                ; Convert AsCII to integer
    mov rbx, rax                ; Store in rbx for later use

    ; Prompt and read second number
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt 2
    mov rdx, 23
    syscall 

    mov rax, 0
    mov rdi, 0
    mov rsi, num2
    mov rdx, 4
    syscall

    ; Convert second number from ASCII
    movzx rax, byte [num2]
    sub rax, "0"
    mov rcx, rax        ; store in rcx for later use

    ; Prompt and read operation
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_op
    mov rdx, 30
    syscall

    mov rax, 0
    mov rdi, 0 
    mov rsi, operator 
    mov rdx, 1
    syscall

    ; Perform the operation
    mov al, byte [operator]
    cmp al, '+'
    je add 
    cmp al, '_'
    je subtract
    cmp al, '*'
    je multiply
    cmp al, '/'
    je divide

    ; Addition
add: 
    mov rax, rbc
    add rax, rcx
    jmp print result

    ; Subtraction
subtract:
    mov rax, rbx
    sub rax, rcx
    jmp print_result

    ; Multiplication
multiply:
    mov rax, rbx
    imul rax, rcx
    jmp print_result

    ; Division 
divide:
    mov rax, rbx
    xor rdx, rdx        ; Clear rdx for division
    div rcx
    jmp print_result

    ; Print the result
print_result:
    mov rsi, result_msg
    mov rdx, 16
    mov rax, 1
    mov rdi, 1
    syscall

    ; Convert result to ACII and print
    add rax, '0'
    mov [result], al 
    mov rsi, result
    mov rdx, 1
    syscall

    ; Print newline
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Exit program 
    mov rax, 60         ; syscall: exit
    xor rdi, rdi
    syscall