;Print routine to be included
;ONLY INCLUDE AFTER STACK HAS BEEN INITIALIZED
;use the BX register as parameter for address of string or char
print_string:
	mov ah, 0x0e
	mov dl, [bx]
	cmp dl, 0
	je print_string_end
	mov al, dl
	int 0x10
	add bx, 1
	jmp print_string
	
print_string_end:
	ret

print_char:
	mov ah, 0x0e
	mov al, [bx]
	int 0x10
	ret
