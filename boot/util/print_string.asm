;; print_string function. argument: bx (string to print)
;; bx must point to a null terminated string
print_string:
  pusha
  mov ah, 0xe                   ; BIOS scrolling tele-type output

print_string_loop:
  mov al, [bx]                  ; Store character in al
  cmp al, 0x0                   ; check if character is the nullbyte
  je print_string_done          ; if it is we're done
  int 0x10                      ; otherwise, print the character
  add bx, 0x1                   ; move onto next character in the string
  jmp print_string_loop

print_string_done:
  popa
  ret
