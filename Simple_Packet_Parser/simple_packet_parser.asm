section .data 
    packet_file db "packet.bin", 0      ; Input packet file 
    source_msg  db "Source IP: ", 0
    dest_msg db "Destination IP: ", 0
    payload_msg db "Payload: ", 0 
    newline db 10, 0                    ; Newline character for formatting

section .bss
    packet resb 256                     ; Buffer to store the packet
    source_ip resb 16                   ; Buffer for source IP string
    dest_ip resb 16                     ; Buffer for destination IP string
    payload resb 128                    ; Buffer for payload 

section .text
    global _start

_start:
    ; Step 1: Load the packet
    mov rdi, packet_file                ; Filename
    call read_packet                    ; Read packet into buffer

    ; Step 2: Extract and convert Source IP
    lea rsi, [packet]                   ; Pointer to Source IP (Bytes 0-3)
    lea rdi, [source_ip]                ; Output buffer
    call parse_ip                       ; Convert binary to string

    ; Step 3: Extract and convert Destination IP 
    lea rsi, [packet + 4]               ; Pointer to Destination IP (Bytes 4-7)
    lea rdi, [dest_ip]                  ; Output buffer
    call parse_ip                       ; Convery to binary string

    ; Step 4: Extract Payload
    lea rsi, [packet + 8]               ; Pointer to Payload
    lea rdi, [payload]                  ; Output buffer
    call extract_payload                ; Extract null-terminated string

    ; Step 4: Display Results
    mov rsi, source_msg
    call print_string
    mov rsi, source_ip
    call print_string 
    call print_newline

    mov rsi, dest_msg
    call print_string
    mov rsi, dest_ip
    call print_string
    call print_newline

    mov rsi, payload_msg
    call print_string
    mov rsi, payload 
    call print_string
    call print_newline

    ; Exit 
    mov rax, 60                     ; Syscall: exit
    xor rdi, rdi                    ; Exit code: 0

; Reads packet from file
read_packet:
    mov rax, 2                      ; syscall: open
    mov rdi, rsi                    ; Filename
    mov rsi, 0                      ; Flags: read-only
    syscall
    mov rdi, rax                    ; File descriptor
    lea rsi, [packet]               ; Buffer
    mov rdx, 256                    ; syscall: read 
    syscall 
    ret 

; Converts binary IP to string
parse_ip:
    xor rcx, rcx                    ; Reset counter 
.ip_loop:
    mov al, byte [rsi + rcx]        ; Load one byte
    call byte_to_dec                ; Convert to decimal string
    mov [rdi + rcx * 4], al         ; Store decimal
    inc rcx
    cmp rcx, 4                      ; Check if all 4 bytes processed
    jl .ip_loop
    ret 

; Extracts null-terminated string
extract_payload: 
    xor rcx, rcx                    ; Reset counter
.payload_loop:
    mov al, byte [rsi + rcx]        ; Load byte
    cmp al, 0                       ; Check for null terminator
    je .done
    mov [rdi + rcx], al             ; Store in output buffer
    inc rcx 
    jmp .payload_loop
.done:
    ret 

; Converts byte to decimal string
byte_to_dec:
    ; Convert byte to decimal and store in a string (e.g., "192")
    ; Code omitted for brevity
    ret 

; Prints a string
print_string:
    mov rax, 1                          ; syscall: write
    mov rdx, 1                          ; File descriptor: stdout
    mov rdx, rsi                        ; String length
    syscall
    ret 

; Prints a newline
print_newline:
    mov rax, 1 
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall 
    ret 
