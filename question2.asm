section .data
    prompt db "Enter 5 integers separated by spaces: ", 0
    array db 5, 0 ; Array size (first element is count)
    output db "Reversed array: ", 0

section .bss
    temp resd 1 ; Temporary variable for swapping

section .text
    global _start

_start:
    ; Print the prompt
    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor (stdout)
    mov ecx, prompt    ; message to print
    mov edx, 31        ; message length
    int 0x80           ; syscall

    ; Read user input 
    
    ; Simulate hardcoded array (user input simulation)
    mov dword [array + 1], 1 ; First integer
    mov dword [array + 5], 2 ; Second integer
    mov dword [array + 9], 3 ; Third integer
    mov dword [array + 13], 4 ; Fourth integer
    mov dword [array + 17], 5 ; Fifth integer

    ; Reverse the array in place
    ; --------------------------
    mov ecx, 0          ; Counter for left index
    mov ebx, 4          ; Counter for right index (5 elements, so 4th index)

reverse_loop:
    cmp ecx, ebx        ; If left index >= right index, stop
    jge done_reversing

    ; Swap array[ecx] and array[ebx]
    ; Load array[ecx] into temp
    mov eax, [array + ecx * 4 + 1] ; Offset by size + array start
    mov [temp], eax

    ; Move array[ebx] to array[ecx]
    mov eax, [array + ebx * 4 + 1]
    mov [array + ecx * 4 + 1], eax

    ; Move temp to array[ebx]
    mov eax, [temp]
    mov [array + ebx * 4 + 1], eax

    ; Increment left index and decrement right index
    inc ecx
    dec ebx
    jmp reverse_loop

done_reversing:
    ; Output the reversed array
    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor (stdout)
    mov ecx, output    ; message to print
    mov edx, 18        ; message length
    int 0x80           ; syscall

    ; Print each element (loop)
    mov ecx, 0         ; Index
print_loop:
    cmp ecx, 5         ; If we've printed all elements, exit loop
    jge exit

    ; Print array[ecx]
    mov eax, [array + ecx * 4 + 1] ; Load value
    add eax, '0'       ; Convert to ASCII (if single-digit integers)
    mov [temp], eax    ; Temporarily store ASCII value

    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor (stdout)
    lea ecx, [temp]    ; Address of ASCII value
    mov edx, 1         ; Print 1 character
    int 0x80           ; syscall

    ; Print a space
    mov eax, 4
    mov ebx, 1
    mov ecx, ' '
    mov edx, 1
    int 0x80

    inc ecx            ; Next index
    jmp print_loop

exit:
    ; Exit the program
    mov eax, 1         ; sys_exit
    xor ebx, ebx       ; exit code 0
    int 0x80