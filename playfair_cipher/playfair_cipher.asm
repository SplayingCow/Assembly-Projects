section .data
    usage_msg db "Usage: ./playfair_cipher <encrypt|decrypt> <file> <keyword>", 0
    success_encrpyt db "Encryption successful! Saved as encrypted.txt", 0
    success_decrypt db "Decryption successful! Saved as decrypted.txt", 0
    error_msg db "Error: Invalid input or keyword", 0
    alphabet db "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0 ; I/J combined
    newline db 10, 0

section .bss
    key_square resb 25             ; 5x5 grid (25 letters)
    buffer resb 256                ; Input file content
    pairs_buffer resb 256          ; Digraph pairs
    result_buffer resb 256         ; Encrypted/decrypted text

section .text
    global _start

_start:
    ; Validate arguments 
    mov rdi, [rsp]                  ; Get argc
    cmp rdi, 4 
    jb usage_error

    ; Parse mode
    mov rsi, [rsp + 8]
    movzx rbx, byte [rsi]
    cmp rbx, 'e'                    ; Encrypt mode
    je encrypt_mode
    cmp rbx, 'd'                    ; Decrypt mode
    je decrypt_mode
    jmp usage_error

encrypt_mode:
    move rsi, [rsp + 16]            ; File path
    mov rdx, [rsp + 24]             ; Keyword
    call generate_key_square        ; Generate 5x5 grid
    call process_text_pairs         ; Prepare digraph pairs
    call encrypt_pairs              ; Encrypt text
    mov rsi, success_encrpyt
    call print_string
    call print_newline
    jmp exit_program

decrypt_mode: 
    mov rsi, [rsp + 16]             ; File path
    mov rdx, [rsp + 24]             ; Keyword
    call generate_key_square        ; Generate 5x5 grid
    call process_text_pairs         ; Prepare digraph pairs
    call decrypt_pairs              ; Decrypt text
    mov rsi, success_encrpyt
    call print_string
    call print_newline
    jmp exit_program

decrypt_mode:
    mov rsi, [rsp + 16]             ; File path
    mov rdx, [rsp + 24]             ; Keyword
    call generate_key_square        ; Generate 5x5 grid
    call process_text_pairs         ; Prepare digraph pairs
    call decrypt_pairs              ; Decrypt text
    mov rsi, success_decrypt
    call print_string
    call print_newline
    jmp exit_program

generate_key_square:
    ; Generate the 5x5 grid from the keyword
    ; Code omitted for brevity
    ret 

process_text_pairs: 
    ; Split input text into digraph pairs
    ; Code omitted for brevity 
    ret

encrypt_pairs: 
    ; Encrypt digraph pairs using Playfair rules
    ; Code omitted for brevity 
    ret 

decrypt_pairs:
    ; Decrypt digraph pairs using Playfair rules
    ; Code omited for brevity
    ret 

exit_program:
    mov rax, 60 
    xoir rdi, rdi 
    syscall

print_string:
    mov rax, 1
    mov rdi, 1
    syscall

print_newline:
    mov rax, 1
    mov rdi, 1 
    mov rsi, newline
    mov rdx, 1
    syscall
    ret