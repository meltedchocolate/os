
	
mov ah, 0x0e

mov bp, 0x8000			;Set up stack, with enough room to grow downwards
mov sp, bp

mov al, [ the_secret ]
int 0x10 					; Does this print an X?
mov bx, 0x7c0				; Can ’t set ds directly , so set bx
mov ds, bx 				; then copy bx to ds.
mov al, [ the_secret ]
int 0x10 					; Does this print an X?
mov al, [es: the_secret ] 	; Tell the CPU to use the es ( not ds) segment.
int 0x10 					; Does this print an X?
mov bx, 0x7c0
mov es, bx
mov al, [es: the_secret ]
int 0x10 					; Does this print an X?

	
jmp $						;Jump to current position and loop forever

%include "print.asm"

;Data
the_secret:
	db "x"
	
times 510-($-$$) db 0	;Repeat 0x00 510-(the amount of space already used)
						; to pad the file with 0s until the magic number

dw 0xaa55				;Define a word (two bytes, since we are in 16 bit real mode)
						; that has the magic number (0xaa55) that tells the bios we
						; are the boot sector.