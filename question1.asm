section .data
    prompt db "Enter a number: ", 0
    positive_msg db "The number is POSITIVE.", 0
    negative_msg db "The number is NEGATIVE.", 0
    zero_msg db "The number is ZERO.", 0

section .bss
    input resb 10   ; Reserve space for user input

section .text
    global _start

_start:
    ; Prompt user for input
    mov eax, 4          ; syscall: write
    mov ebx, 1          ; file descriptor: stdout
    mov ecx, prompt     ; message to display
    mov edx, 16         ; length of the message
    int 0x80            ; call kernel

    ; Read user input
    mov eax, 3          ; syscall: read
    mov ebx, 0          ; file descriptor: stdin
    mov ecx, input      ; buffer to store input
    mov edx, 10         ; buffer size
    int 0x80            ; call kernel

    ; Convert input to integer
    mov esi, input      ; address of input buffer
    xor eax, eax        ; clear EAX (number accumulator)
    xor ebx, ebx        ; clear EBX (negative flag)

convert_loop:
    movzx ecx, byte [esi]   ; load byte from input
    cmp ecx, 10             ; check for newline (Enter key)
    je classify_number       ; if newline, jump to classify_number
    sub ecx, '0'            ; convert ASCII to integer
    imul eax, eax, 10       ; multiply accumulator by 10
    add eax, ecx            ; add digit to accumulator
    inc esi                 ; move to next character
    jmp convert_loop        ; unconditional jump to continue

classify_number:
    ; Check if the number is positive, negative, or zero
    cmp eax, 0
    je is_zero              ; conditional jump if EAX == 0

    ; If not zero, check if positive
    jg is_positive          ; conditional jump if EAX > 0

    ; If not zero or positive, it's negative
    jmp is_negative         ; unconditional jump

is_positive:
    mov eax, 4              ; syscall: write
    mov ebx, 1              ; file descriptor: stdout
    mov ecx, positive_msg   ; message to display
    mov edx, 22             ; length of the message
    int 0x80                ; call kernel
    jmp exit_program        ; unconditional jump to exit

is_negative:
    mov eax, 4              ; syscall: write
    mov ebx, 1              ; file descriptor: stdout
    mov ecx, negative_msg   ; message to display
    mov edx, 22             ; length of the message
    int 0x80                ; call kernel
    jmp exit_program        ; unconditional jump to exit

is_zero:
    mov eax, 4              ; syscall: write
    mov ebx, 1              ; file descriptor: stdout
    mov ecx, zero_msg       ; message to display
    mov edx, 18             ; length of the message
    int 0x80                ; call kernel

exit_program:
    ; Exit the program
    mov eax, 1              ; syscall: exit
    xor ebx, ebx            ; status code 0
    int 0x80                ; call kernel
