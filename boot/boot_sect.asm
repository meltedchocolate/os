[org 0x7c00]

KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl

mov bp, 0x9000			;Set up stack, with enough room to grow downwards
mov sp, bp

mov bx, REAL_MODE_MSG
call print_string

call load_kernel

call switch_to_pm

jmp $						;Jump to current position and loop forever

%include "boot/util/print_string.asm"
%include "boot/util/disk.asm"
%include "boot/gdt/gdt.asm"
%include "boot/util/print_string_pm.asm"
%include "boot/switch_to_pm.asm"

[bits 16]
load_kernel:
	mov bx, LOAD_KERNEL_MSG	;Print a message saying we are loading the kernel
	call print_string
	mov bx, KERNEL_OFFSET  		;Set up disk_load routine parameters
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call disk_load				;Call disk_load
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


	