[bits 16]
; switch to protected mode

switch_to_pm:
  cli                           ; disable interrupts
  lgdt [gdt_descriptor]         ; Load the gdt

  mov eax, cr0                  ; Set the first bit of the relevant control register
  or eax, 0x1
  mov cr0, eax

  jmp CODE_SEG:init_pm          ; far jump to force cpu to finish executing real-mode instructions

[bits 32]
; initialize registers and the stack once in protected mode
init_pm:
  mov ax, DATA_SEG              ; use the data segment defined in the gdt
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000              ; move stack position to the top of the free space
  mov esp, ebp

  jmp BEGIN_PM
