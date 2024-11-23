section .data
    sensor_value db 0           ; Simulated sensor value (water level)
    motor_status db 0           ; Motor status: 0 = off, 1 = on
    alarm_status db 0           ; Alarm status: 0 = off, 1 = on

    high_threshold db 8         ; High water level threshold
    moderate_threshold db 5     ; Moderate water level threshold

section .text
    global _start

_start:
    ; Step 1: Read the sensor value
    mov al, [sensor_value]      ; Load sensor value into AL

    ; Step 2: Compare sensor value and take actions
    mov bl, [high_threshold]    ; Load high threshold
    cmp al, bl                  ; Compare sensor value with high threshold
    jg high_water_level         ; If water level > high, go to high_water_level

    mov bl, [moderate_threshold]; Load moderate threshold
    cmp al, bl                  ; Compare sensor value with moderate threshold
    jg moderate_water_level     ; If water level > moderate, go to moderate_water_level

    ; Default action: Water level is low
    call low_water_level
    jmp end_program

high_water_level:
    ; Water level is too high: Turn on alarm and stop motor
    mov byte [alarm_status], 1  ; Set alarm status to ON
    mov byte [motor_status], 0  ; Set motor status to OFF
    jmp end_program

moderate_water_level:
    ; Water level is moderate: Stop motor
    mov byte [motor_status], 0  ; Set motor status to OFF
    mov byte [alarm_status], 0  ; Set alarm status to OFF
    jmp end_program

low_water_level:
    ; Water level is low: Turn on motor
    mov byte [motor_status], 1  ; Set motor status to ON
    mov byte [alarm_status], 0  ; Set alarm status to OFF
    ret

end_program:
    ; Exit program
    mov eax, 1                  ; syscall: sys_exit
    xor ebx, ebx                ; exit code 0
    int 0x80                    ; call kernel
