nasm -f elf64 cmp.asm -o cmp.o -g
gcc -m64 -no-pie -g cmp.o -o cmp
