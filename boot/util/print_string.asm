;Print routine for 16bit real mode
;BX=Adress
[bits 16]
print_string:
	mov ah, 0x0e
	mov al, [bx]
	cmp al, 0x00
	je print_string_end
	int 0x10
	add bx, 1
	jmp print_string
	
print_string_end:
	ret