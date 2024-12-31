section .data
    usage_msg db "Usage: ./substitution_cipher <encrypt|decrypt|analyze> <file> <key>", 0
    success_encrypt db "Encryption successful! Saved as encrypted.txt", 0
    success_decrypt db "Decryption successful! Saved as decrypted.txt", 0
    frequency_msg db "Frequency Analysis:", 0
    alphabet db "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0
    newline db 10, 0

section .bss
    buffer resb 256                ; File buffer
    freq resd 26                   ; Frequency counter for A-Z
    key resb 26                    ; Substitution key
    result_buffer resb 256         ; Output buffer

section .text
    global _start

_start:
    ; Validate command-line arguments
    mov rdi, [rsp]                ; Get argc
    cmp rdi, 3                    ; Ensure at least 3 arguments
    jb usage_error

    ; Parse mode
    mov rsi, [rsp + 8]            ; Get argv[1]
    movzx rbx, byte [rsi]
    cmp rbx, 'e'                  ; Check for "encrypt"
    je encrypt_mode
    cmp rbx, 'd'                  ; Check for "decrypt"
    je decrypt_mode
    cmp rbx, 'a'                  ; Check for "analyze"
    je analyze_mode
    jmp usage_error

encrypt_mode:
    mov rsi, [rsp + 16]           ; Get file path (argv[2])
    mov rdx, [rsp + 24]           ; Get key (argv[3])
    call validate_key             ; Ensure key is valid
    call encrypt_file             ; Perform encryption
    mov rsi, success_encrypt
    call print_string
    call print_newline
    jmp exit_program

decrypt_mode:
    mov rsi, [rsp + 16]           ; Get file path (argv[2])
    mov rdx, [rsp + 24]           ; Get key (argv[3])
    call validate_key             ; Ensure key is valid
    call decrypt_file             ; Perform decryption
    mov rsi, success_decrypt
    call print_string
    call print_newline
    jmp exit_program

analyze_mode:
    mov rsi, [rsp + 16]           ; Get file path (argv[2])
    call analyze_file             ; Perform frequency analysis
    mov rsi, frequency_msg
    call print_string
    call print_newline
    jmp exit_program

validate_key:
    ; Validate the substitution key (26 unique letters)
    ; Code omitted for brevity
    ret

encrypt_file:
    ; Open, read, substitute characters, write to encrypted.txt
    ; Code omitted for brevity
    ret

decrypt_file:
    ; Open, read, reverse substitution, write to decrypted.txt
    ; Code omitted for brevity
    ret

analyze_file:
    ; Perform frequency analysis
    xor rcx, rcx                  ; Clear counter
    mov rsi, buffer
.analyze_loop:
    mov al, [rsi + rcx]           ; Load character
    cmp al, 'A'
    jb .skip                      ; Skip non-alphabet characters
    cmp al, 'Z'
    ja .skip
    sub al, 'A'                   ; Convert A-Z to 0-25
    inc dword [freq + rax * 4]    ; Increment frequency
.skip:
    inc rcx
    cmp rcx, 256
    jl .analyze_loop
    ret

exit_program:
    mov rax, 60                   ; syscall: exit
    xor rdi, rdi                  ; Exit code: 0
    syscall

print_string:
    mov rax, 1
    mov rdi, 1
    syscall
    ret

print_newline:
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    ret

