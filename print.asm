;Print routine to be included
;ONLY INCLUDE AFTER STACK HAS BEEN INITIALIZED
;use the BX register as parameter for address of string
print:
	mov ah, 0x0e
	mov dl, [bx]
	cmp dl, 0
	je end
	mov al, dl
	int 0x10
	add bx, 1
	jmp print
	
end:
	ret