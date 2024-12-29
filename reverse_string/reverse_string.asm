section .data
    prompt db "Enter a string: ", 0
    result_msg db "Reversed string: ", 0 
    newlien db 10, 0

section .bss 
    input resb 128          ; Reserve space  input (128 bytes max)
    reversed resb 128       ; Reserve space for the reversed string

section .text
    global _start

_start:
    ; Prompt user for input 
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, prompt     ; address of the prompt string
    mov rdx, 16         ; length of the prompt
    syscall

    ; Read user input 
    mov rax, 0          ; syscall: read     
    mov rdi, 0          ; file descriptor: stdin
    mov rsi, input      : address of the input buffer
    mov rdx, 128        ; max input length
    syscall

    ; Calculate string length 
    mov rsi, input      ; rsi points to the start of the string
    xor rcx, rcx        ; rcx will count the string length

strlen_loop:
    cmp byte [rsi], 10  ; Check for newline character
    je reverse_string   ; If newline, stop counting
    cmp byte [rsi], 0   ; Check for null terminator
    je reverse_string   ; If null, stop counting
    inc rsi             ; Move to the next character
    inc rcx             ; Increment the length counter
    jmp strlen_loop

reverse_string:
    ; Set up pointers
    mov rsi, input      ; rsi points to the start of the input string
    mov rdi, reversed   ; rdi points to the start of the reversed buffer
    add rsi, rcx        ; Move rsi to the end of the string
    dec rsi             ; Adjust to point to the last character

reverse_loop:
    cmp rcx, 0          ; Check if we've processed all characters
    je print_result     ; If yes, jump to printing
    mov al, [rsi]       ; Load the character from the input string
    mov [rdi], al       ; Store it in the reversed buffer
    dec rsi             ; Move rsi to the previous character
    inc rdi             ; Move rdi to the next character
    dec rcx             ; Decreased the length counter
    jmp reverse_loop

print_result:
    ; Print the result message
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, result_msg ; address of the result message
    mov rdx, 17         ; length of the message
    syscall

    ; Print the reversed string
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, reversed   ; address of the reversed string
    mov rdx, 128        ; max length of the reversed string
    syscall

    ; Print newline
    mov rax, 1          ;  syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, newline    ; address of the newline character
    mov rdx, 1          ; length of the newline
    syscall

    ; exit the porgram
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; edit code: 0
    syscall