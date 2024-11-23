section .data
    prompt db "Enter a number: ", 0       ; Input prompt
    result_msg db "Factorial is: ", 0     ; Output message

section .bss
    num resb 1                            ; Reserve space for input number
    factorial resd 1                      ; Reserve space for factorial result

section .text
    global _start

_start:
    ; Display prompt
    mov eax, 4                            ; syscall: sys_write
    mov ebx, 1                            ; stdout
    mov ecx, prompt                       ; message address
    mov edx, 15                           ; message length
    int 0x80                              ; call kernel

    ; Read input number
    mov eax, 3                            ; syscall: sys_read
    mov ebx, 0                            ; stdin
    mov ecx, num                          ; buffer to store input
    mov edx, 1                            ; number of bytes to read
    int 0x80                              ; call kernel

    ; Convert input character to integer
    movzx eax, byte [num]                 ; load input character
    sub eax, '0'                          ; convert ASCII to integer
    mov ebx, eax                          ; store the number in ebx

    ; Call factorial subroutine
    push ebx                              ; push input number onto stack
    call factorial_calc                   ; call factorial subroutine
    add esp, 4                            ; clean up the stack

    ; Store result for printing
    mov [factorial], eax                  ; store factorial result

    ; Display result message
    mov eax, 4                            ; syscall: sys_write
    mov ebx, 1                            ; stdout
    mov ecx, result_msg                   ; message address
    mov edx, 14                           ; message length
    int 0x80                              ; call kernel

    ; Print result (convert integer to string for display)
    mov eax, [factorial]                  ; load factorial result
    call print_number                     ; print the result

    ; Exit program
    mov eax, 1                            ; syscall: sys_exit
    xor ebx, ebx                          ; exit code 0
    int 0x80                              ; call kernel

; Subroutine: Factorial Calculation
factorial_calc:
    push ebp                              ; save base pointer
    mov ebp, esp                          ; establish new base pointer
    push ebx                              ; save ebx (caller-saved register)

    mov eax, 1                            ; initialize result to 1
    mov ecx, [ebp+8]                      ; get input number from stack

.factorial_loop:
    cmp ecx, 1                            ; check if ecx <= 1
    jle .done                             ; if true, exit loop
    mul ecx                               ; eax = eax * ecx
    dec ecx                               ; decrement ecx
    jmp .factorial_loop                   ; repeat loop

.done:
    pop ebx                               ; restore ebx
    pop ebp                               ; restore base pointer
    ret                                   ; return result in eax

; Subroutine: Print Number
print_number:
    push ebp                              ; save base pointer
    mov ebp, esp                          ; establish new base pointer
    sub esp, 16                           ; reserve space for number string

    mov edi, esp                          ; pointer to buffer
    mov ecx, 10                           ; divisor (base 10)

.convert_loop:
    xor edx, edx                          ; clear edx for division
    div ecx                               ; eax = eax / 10, edx = remainder
    add dl, '0'                           ; convert remainder to ASCII
    dec edi                               ; move pointer backward
    mov [edi], dl                         ; store ASCII character
    test eax, eax                         ; check if quotient is 0
    jnz .convert_loop                     ; repeat until eax == 0

    ; Print the number string
    mov eax, 4                            ; syscall: sys_write
    mov ebx, 1                            ; stdout
    mov ecx, edi                          ; pointer to the number string
    mov edx, esp                          ; calculate string length
    sub edx, edi
    int 0x80                              ; call kernel

    add esp, 16                           ; clean up stack space
    pop ebp                               ; restore base pointer
    ret                                   ; return

