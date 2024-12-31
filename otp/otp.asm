section .data
    usage_msg db "Usage: ./otp <encrpyt|decrypt> <file>", 0
    success_encrypt db "Encryption successful! Saved as encrypted.txt and key.txt", 0
    success_decrypt db "Decrpytion successful! Saved as decrypted.txt", 0
    error_msg db "Error: Invalid input or file", 0
    newline db 10, 0 

section .bss
    buffer resb 256                 ; File content buffer
    key_buffer resb 256             ; Random key buffer
    result_buffer resb 256          ; Encrypted or decrypted result

section .text
    global _ start 

_start: 
    ; Validate argumenets
    mov rdi, [rsp]                  ; Get argc
    cmp rdi, 3                      ; Expect 3 arguments
    jb usage_error

    ; Parse mode
    mov rsi, [rsp + 8]
    movzx rbx, byte [rsi]
    cmp rbx, `e`                    ; Encrypt mode 
    je encrypt_mode
    cmp rbx, `d`                    ; Decrypt mode
    je decrypt_mode
    jmp usage_error

encrypt_mode: 
    mov rsi, [rsp + 16]             ; File path
    call read_file                  ; Read ciphertext into buffer
    call read_key_file              ; Read key into key_buffer
    call xor_decrypt                ; Decrypt using XOR 
    call write_decrypted_file       ; Save plaintext
    mov rsi, success_decrypt
    call print_string
    call print_newline
    jmp exit_program

generate_key:
    ; Generate a random key of the same length as the buffer
    xor rcx, rcx                    ; Counter
.generate_loop:
    mov rax, 0                      ; syscall:read
    mov rdi, 0                      ; File descriptor: stdin (or use /dev/urandom)
    lea rsi, [key_buffer + rcx]     ; Address of key
    mov rdx, 1                      ; Read 1 byte
    syscall
    inc rcx
    cmp rcx, 256                    ; Match buffer length
    jl .generate_loop
    ret 

xor_encrypt:
    xor rcx, rcx                    ; Counter
.encrypt_loop:
    mov al, [buffer + rcx]          ; Get plaintext byte
    xor al, [key_buffer + rcx]      ; XOR with key byte
    mov [result_buffer + rcx], al   ; Save result
    inc rcx
    cmp rcx, 256
    jl .encrypt_loop
    ret 

xor_decrypt:
    ; Decrypt is the same as encrypt (XOR is symmetric)
    call xor_encrypt
    ret 

write_encrypted_file:
    ; Write result_buffer to encrypted.txt
    ; Code omitted for brevity
    ret 

write_key_file:
    ; Write key_buffer to key.txt
    ; Code omitted for brevity 
    ret 

write_decrypted_file
    ; Write result_buffer to decrypted.txt
    ; Code omitted for brevity
    ret

read_file
    ; Read file content into buffer
    ; Code omitted for brevity 
    ret 

read_key_file:
    ; Read key into key_buffer
    ; Code omitted for brevity 
    ret 

exit_program: 
    mov rax, 60 
    xor rdi, rdi 
    syscall 

print_string:
    mov rax, 1                      ; syscall: write 
    mov rdi, 1
    syscall 

print_newline:
    mov rax, 1
    mov rdi, 1 
    mov rsi, newline
    mov rdx, 1
    syscall 
    ret 