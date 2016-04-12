nasm ./boot/boot_sect.asm -f bin -o ./bin/boot_sect.bin
cat ./bin/boot_sect.bin ./kernel/kernel.bin > osimage