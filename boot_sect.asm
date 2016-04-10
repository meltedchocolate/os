org 0x7c00

print:
	mov ah, 0x0e			;Set bios routine to printing characters
	mov al, character
	int 0x10
	mov al, [character]
	int 0x10
	mov bx, character
	add bx, 0x7c00
	mov al, [bx]
	int 0x10
	mov al, [0x7c1e]
	int 0x10
	
jmp $					;Jump to current position and loop forever

character:
	db "X"

times 510-($-$$) db 0	;Repeat 0x00 510-(the amount of space already used)
						; to pad the file with 0s until the magic number

dw 0xaa55				;Define a word (two bytes, since we are in 16 bit real mode)
						; that has the magic number (0xaa55) that tells the bios we
						; are the boot sector.