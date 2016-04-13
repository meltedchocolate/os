;; disk_load function. Arguments: dh, bx, dl
;; loads dh sectors to es:bx from drive dl
disk_load:
  pusha
  push dx                       ; store number of sectors requested on stack
  mov ah, 0x02                  ; BIOS read sector
  mov al, dh                    ; store num sectors to read in al
  mov ch, 0x00                  ; store the cylinder id (0) in ch
  mov dh, 0x00                  ; store the head id (0) in dh
  mov cl, 0x02                  ; store the sector id (2) in cl; sector 2 is right after the boot sector
  int 0x13

  jc disk_load_error            ; jump if carry flag is set (there was a problem loading the disk)

  pop dx                        ; restore number of sectors requested
  cmp dh, al
  jne disk_load_error           ; if sectors read is not how many were requested there was an error

  popa
  ret

disk_load_error:
  mov bx, disk_load_ERROR_MSG
  call print_string
  jmp $

disk_load_ERROR_MSG:  db "Disk read error!", 0
