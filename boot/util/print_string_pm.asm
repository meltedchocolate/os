[bits 32]
; constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; print_string_pm function. prints a null-terminated string pointed to by ebx
print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY         ; Let edx point to the start of video memory

print_string_pm_loop:
  mov al, [ebx]                 ; store character in al
  mov ah, WHITE_ON_BLACK        ; store attributes in ah
  cmp al, 0x0
  je print_string_pm_done       ; jump to done when we've reached a null byte

  mov [edx], ax                 ; store char and attributes at the current vid mem cell

  add ebx, 1                    ; point to next character in string
  add edx, 2                    ; point to next cell in vid mem

  jmp print_string_pm_loop      ; loop until we reach a null byte

print_string_pm_done:
  popa
  ret
