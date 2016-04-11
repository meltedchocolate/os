;Print routine for 16bit real mode
;BX=Adress
print_string:
	mov ah, 0x0e
	
print_string_loop:
	mov al, [bx]
	cmp al, 0
	je print_string_end
	int 0x10
	add bx, 1
	jmp print_string_loop
	
print_string_end:
	ret