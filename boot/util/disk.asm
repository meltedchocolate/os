;Load DH sectors to ES:BX from drive DL
disk_load:
	push dx			; Save how many sectors we requested for error checking purposes
	
	mov ah, 0x02	; BIOS read sector function
	mov al, dh
	mov ch, 0x00
	mov dh, 0x00
	mov cl, 0x02
	
	int 0x13
	
	jc disk_error
	pop dx
	cmp dh, al
	jne disk_error
	ret
	
	
disk_error:
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $

DISK_ERROR_MSG db "Error reading sectors on disk.", 0