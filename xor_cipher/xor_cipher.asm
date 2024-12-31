section .data
    usage_msg db "Usage: ./xor_cipher <-e|-d> <file> <key>", 0
    error_msg db "Error: Invalid arguments or file operation failed", 0
    success_encrypt db "File encrypted successfully! Saved as encrypted.txt", 0
    success_decrypt db "File decrypted successfully! Saved as decrypted.txt", 0
    newline db 10, 0

section .bss
    buffer resb 256                ; Buffer for file content
    key_buffer resb 64             ; Buffer for the XOR key

section .text
    global _start

_start:
    ; Validate argument count
    mov rdi, [rsp]                ; Get argc (argument count)
    cmp rdi, 4                    ; Expect 4 arguments (program, mode, file, key)
    je parse_arguments
    jmp usage_error

parse_arguments:
    ; Get the mode (-e or -d)
    mov rsi, [rsp + 8]            ; Get argv[1]
    movzx rbx, byte [rsi]         ; Load the first character of argv[1]
    cmp bl, '-'                   ; Check if mode starts with '-'
    jne invalid_arguments
    cmp byte [rsi + 1], 'e'       ; Check for '-e' (encrypt)
    je encrypt_mode
    cmp byte [rsi + 1], 'd'       ; Check for '-d' (decrypt)
    je decrypt_mode
    jmp invalid_arguments

encrypt_mode:
    mov rsi, [rsp + 16]           ; Get argv[2] (file name)
    mov rdx, [rsp + 24]           ; Get argv[3] (key)
    call xor_encrypt              ; Call encryption function
    mov rsi, success_encrypt
    call print_string
    call print_newline
    jmp exit_program

decrypt_mode:
    mov rsi, [rsp + 16]           ; Get argv[2] (file name)
    mov rdx, [rsp + 24]           ; Get argv[3] (key)
    call xor_decrypt              ; Call decryption function
    mov rsi, success_decrypt
    call print_string
    call print_newline
    jmp exit_program

invalid_arguments:
    ; Print error message
    mov rsi, error_msg
    call print_string
    call print_newline
    jmp exit_program

xor_encrypt:
    ; Open the file for reading
    mov rax, 2                    ; syscall: open
    mov rdi, rsi                  ; File name (argv[2])
    mov rsi, 0                    ; Flags: O_RDONLY
    syscall
    test rax, rax
    js invalid_arguments          ; Jump on error
    mov r12, rax                  ; Store file descriptor

    ; Read the file content
    mov rax, 0                    ; syscall: read
    mov rdi, r12                  ; File descriptor
    mov rsi, buffer               ; Address of buffer
    mov rdx, 256                  ; Maximum bytes to read
    syscall
    test rax, rax
    js invalid_arguments          ; Jump on error
    mov r13, rax                  ; Store number of bytes read

    ; XOR each byte with the key
    xor_loop:
        movzx r8b, byte [buffer + rcx] ; Load byte from buffer
        movzx r9b, byte [rdx + rcx % key_len] ; Load byte from key
        xor r8b, r9b                 ; XOR the byte
        mov [buffer + rcx], r8b      ; Store result back in buffer
        inc rcx                      ; Increment counter
        cmp rcx, r13                 ; Compare counter with bytes read
        jl xor_loop

    ; Write the encrypted data to a file
    mov rax, 2                    ; syscall: open
    mov rdi, encrypted_filename   ; File name ("encrypted.txt")
    mov rsi, 0x41                 ; Flags: O_CREAT | O_WRONLY
    mov rdx, 0o644                ; Permissions
    syscall
    mov r12, rax                  ; Store file descriptor
    mov rax, 1                    ; syscall: write
    mov rdi, r12                  ; File descriptor
    mov rsi, buffer               ; Address of buffer
    mov rdx, r13                  ; Number of bytes
    syscall
    mov rax, 3                    ; syscall: close
    mov rdi, r12                  ; File descriptor
    syscall
    ret

xor_decrypt:
    ; Decryption is identical to encryption (XOR is symmetric)
    call xor_encrypt
    ret

exit_program:
    mov rax, 60                   ; syscall: exit
    xor rdi, rdi                  ; Exit code: 0
    syscall

print_string:
    mov rax, 1                    ; syscall: write
    mov rdi, 1                    ; File descriptor: stdout
    syscall
    ret

print_newline:
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    ret
