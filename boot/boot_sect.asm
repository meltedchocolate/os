[org 0x7c00]

KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl    ;Get the current boot drive from the BIOS

xor ax, ax
mov ds, ax              ;DS=0 because we use org 0x7c00

mov bx, 0x8000
mov ss, bx
mov sp, ax              ;Set up stack starting at 0x8000:0x0000

mov bx, REAL_MODE_MSG
call print_string

call load_kernel

call switch_to_pm

jmp $                       ;Jump to current position and loop forever

%include "util/print_string.asm"
%include "util/disk.asm"
%include "gdt.asm"
%include "util/print_string_pm.asm"
%include "switch_to_pm.asm"

[bits 16]
load_kernel:
    mov bx, LOAD_KERNEL_MSG ;Print a message saying we are loading the kernel
    call print_string
    mov bx, KERNEL_OFFSET       ;Set up disk_load routine parameters
    mov dh, 15
    mov dl, [BOOT_DRIVE]
    call disk_load              ;Call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, PROT_MODE_MSG
    call print_string_pm
    call KERNEL_OFFSET
    jmp $

; Data
BOOT_DRIVE: db 0
REAL_MODE_MSG: db "Started in real mode.", 0
PROT_MODE_MSG: db "Successfully entered 32-bit protected mode.", 0
LOAD_KERNEL_MSG: db "Loading Kernel into memory", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
