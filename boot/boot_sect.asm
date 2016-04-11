[org 0x7c00]

mov bp, 0x9000			;Set up stack, with enough room to grow downwards
mov sp, bp

mov bx, REAL_MODE_MSG
call print_string
;call switch_to_pm
jmp $						;Jump to current position and loop forever

%include "boot/util/print_string.asm"
%include "boot/gdt/gdt.asm"
%include "boot/util/print_string_pm.asm"
%include "boot/switch_to_pm.asm"

BEGIN_PM:
	mov ebx, PROT_MODE_MSG
	call print_string_pm
	jmp $

; Data
REAL_MODE_MSG: db "Exiting real mode.", 0
PROT_MODE_MSG: db "Successfully entered 32-bit protected mode.", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55


	