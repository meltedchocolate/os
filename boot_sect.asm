[org 0x7c00]
	
mov ah, 0x0e

mov bp, 0x8000			;Set up stack, with enough room to grow downwards
mov sp, bp

mov bx, STRING
call print

mov bx, SECOND_STRING
call print
	
jmp $					;Jump to current position and loop forever

%include "print.asm"

;Data
STRING:
	db 'hello, world! ', 0
	
SECOND_STRING:
	db 'THIS ACTUALLY WORKS WHAT ', 0
	
times 510-($-$$) db 0	;Repeat 0x00 510-(the amount of space already used)
						; to pad the file with 0s until the magic number

dw 0xaa55				;Define a word (two bytes, since we are in 16 bit real mode)
						; that has the magic number (0xaa55) that tells the bios we
						; are the boot sector.