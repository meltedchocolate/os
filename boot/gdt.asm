;Global Descriptor Table
gdt_start:

gdt_null:   ; We need a null descriptor at the start (8 bytes)
    dd 0x0
    dd 0x0

gdt_code:   ; Code segment descriptor
    ; Base=0x0, Limit=0xfffff
    ; 1st flags : (present)1 (privilege)00 (descriptor type)1 -> 1001b
    ; type flags : (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags : (granularity)1 (32 - bit default)1 (64 - bit seg)0 (AVL)0 -> 1100b
    dw 0xffff       ; Limit (bits 0-15)
    dw 0x0      ; Base (0-15)
    db 0x0          ; Base (16-23)
    db 10011010b    ; 1st flags and type flags
    db 11001111b    ; 2nd flags and Limit (16-19)
    db 0x0          ; Base (24-31)

gdt_data:   ; Data segment descriptor
    ;Same as CSD except for type flags
    ; (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
    dw 0xffff       ; Limit (bits 0-15)
    dw 0x0          ; Base (0-15)
    db 0x0          ; Base (16-23)
    db 10010010b    ; 1st flags and type flags
    db 11001111b    ; 2nd flags and Limit (16-19)
    db 0x0          ; Base (24-31)

gdt_end:


;GDT Descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

;Some Constants
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
