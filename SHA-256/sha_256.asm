section .data 
    input_msg db "hello", 0                    ; Input message
    input_len dq 5                             ; Length of the input message
    padded_msg resb 64                         ; Buffer for 512-bit padded message
     H db 0x6a, 0x09, 0xe6, 0x67, 0xbb, 0x67, 0xae, 0x85, 0x3c, 0x6e, 0xf3, 0x72, 0xa5, 0x4f, 0xf5, 0x3a
    K db 0x42, 0x8a, 0x2f, 0x98, 0x71, 0x37, 0x44, 0x91, 0xb5, 0xc0, 0xfb, 0xcf, 0xe9, 0xb5, 0xdb, 0xa5

section .bss
    W resb 256                               ; Buffer for 64 32-bit words
    hash resb 32                             ; Final hash output

section .text
    global_start

_start:
    ; Step 1: Preprocess Input
    lea rsi, [input_msg]
    mov rdi, input_len
    lea rdx, [padded_msg]
    call preprocess_input

    ; Step 2: Initialize Hash Values
    lea rsi, [H]
    call initialize_hash_values

    ; Step 3: Process Chunks
    lea rsi, [padded_msg]
    lea rdx, [W]
    lea rdi, [h]
    call process_chunks 

    ; Step 4: Produce Final Hash
    lea rsi, [H]
    lea rdi, [hash]
    call produce_final_hash

    ; Exit 
    mov rax, 60 
    xor rdi, rdi 
    syscall

; Preprocess Input: Pad message and prepare for hashing
preprocess_input:
    ; Add code to pad message to 512 bits
    ; Append original length as a 64-bit value
    ret 

; Initialize Hash Values: Load initial hash constants 
initialize_hash_values:
    ; Copy predfined hash values to registers or memory 
    ret 

; Process Chunks: Perform main loop of SHA-256
process_chunks:
    ; Break input into 512-bit chunks and process each
    ; Use the 64 round constants and logicla functions
    ret 
; Produce Final Hash: Combine intermediate hash values
produce_final_hash
    ; Combine H0-H7 into final 256-bit hash
    ret
    