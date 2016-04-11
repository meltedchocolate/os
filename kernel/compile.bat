"C:\Program Files (x86)\CodeBlocks\MinGW\bin\gcc" -ffreestanding -c kernel.c -o kernel.o
"C:\Program Files (x86)\CodeBlocks\MinGW\bin\ld" -o kernel.tmp -Ttext 0x1000 kernel.o
objcopy -O binary kernel.tmp kernel.bin
PAUSE