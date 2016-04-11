[org 0x7c00]

mov bp, 0x8000			;Set up stack, with enough room to grow downwards
mov sp, bp

mov bx, 0x9000
mov dh, 1
mov dl, [BOOT_DRIVE]
call disk_load

mov bx, 0x9000
call print_string

jmp $						;Jump to current position and loop forever

%include "print.asm"
%include "disk.asm"
;Data
BOOT_DRIVE: db 0

times 510-($-$$) db 0	;Repeat 0x00 510-(the amount of space already used)
						; to pad the file with 0s until the magic number

dw 0xaa55				;Define a word (two bytes, since we are in 16 bit real mode)
						; that has the magic number (0xaa55) that tells the bios we
						; are the boot sector.
times 511 db 'A'
db 0x00