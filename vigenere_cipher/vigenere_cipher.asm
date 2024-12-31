section .data
    usage_msg db "Usage: ./vigenere_cipher <encrypt|decrypt> <file> <keyword>", 0
    success_encrypt db "Encryption successful! Saved as encrypted.txt", 0
    success_decrypt db "Decryption successful! Saved as decrypted.txt", 0
    error_msg db "Error: Invalid input or keyword", 0
    alphabet db "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0
    newline db 10, 0

section .bss
    buffer resb 256                ; File buffer
    keyword_expanded resb 256      ; Expanded keyword
    result_buffer resb 256         ; Result buffer

section .text
    global _start

_start:
    ; Validate argument count
    mov rdi, [rsp]                ; Get argc
    cmp rdi, 4                    ; Expect 4 arguments
    jb usage_error

    ; Parse mode
    mov rsi, [rsp + 8]            ; Get argv[1]
    movzx rbx, byte [rsi]
    cmp rbx, 'e'                  ; Check for "encrypt"
    je encrypt_mode
    cmp rbx, 'd'                  ; Check for "decrypt"
    je decrypt_mode
    jmp usage_error

encrypt_mode:
    mov rsi, [rsp + 16]           ; Get file path (argv[2])
    mov rdx, [rsp + 24]           ; Get keyword (argv[3])
    call validate_keyword         ; Ensure keyword is valid
    call expand_keyword           ; Expand keyword to match text length
    call encrypt_file             ; Encrypt text
    mov rsi, success_encrypt
    call print_string
    call print_newline
    jmp exit_program

decrypt_mode:
    mov rsi, [rsp + 16]           ; Get file path (argv[2])
    mov rdx, [rsp + 24]           ; Get keyword (argv[3])
    call validate_keyword         ; Ensure keyword is valid
    call expand_keyword           ; Expand keyword to match text length
    call decrypt_file             ; Decrypt text
    mov rsi, success_decrypt
    call print_string
    call print_newline
    jmp exit_program

validate_keyword:
    ; Ensure the keyword contains only letters
    xor rcx, rcx                  ; Counter
.validate_loop:
    mov al, byte [rdx + rcx]      ; Get current character
    cmp al, 0                     ; End of string
    je .done
    cmp al, 'A'
    jb invalid_keyword
    cmp al, 'Z'
    ja invalid_keyword
    inc rcx
    jmp .validate_loop
.done:
    ret
invalid_keyword:
    mov rsi, error_msg
    call print_string
    call print_newline
    jmp exit_program

expand_keyword:
    ; Expand the keyword to match the length of the text
    xor rcx, rcx                  ; Counter for text
    xor r8, r8                    ; Counter for keyword
.expand_loop:
    mov al, byte [buffer + rcx]   ; Get text character
    cmp al, 0                     ; End of text
    je .done
    mov al, byte [rdx + r8]       ; Get keyword character
    mov byte [keyword_expanded + rcx], al
    inc rcx
    inc r8
    movzx r9, byte [rdx + r8]
    cmp r9, 0                     ; If end of keyword, reset
    jne .expand_loop
    xor r8, r8
    jmp .expand_loop
.done:
    ret

encrypt_file:
    ; Encrypt text using expanded keyword
    xor rcx, rcx
.encrypt_loop:
    mov al, [buffer + rcx]
    cmp al, 0                     ; End of text
    je .done
    sub al, 'A'                   ; Map A-Z to 0-25
    mov bl, [keyword_expanded + rcx]
    sub bl, 'A'
    add al, bl                    ; Add keyword shift
    mod 26                        ; Wrap around
    add al, 'A'
    mov [result_buffer + rcx], al
    inc rcx
    jmp .encrypt_loop
.done:
    ret

decrypt_file:
    ; Decrypt text using expanded keyword
    xor rcx, rcx
.decrypt_loop:
    mov al, [buffer + rcx]
    cmp al, 0                     ; End of text
    je .done
    sub al, 'A'                   ; Map A-Z to 0-25
    mov bl, [keyword_expanded + rcx]
    sub bl, 'A'
    sub al, bl                    ; Subtract keyword shift
    mod 26                        ; Wrap around
    add al, 'A'
    mov [result_buffer + rcx], al
    inc rcx
    jmp .decrypt_loop
.done:
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

