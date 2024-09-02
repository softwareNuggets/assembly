## nasm -f elf64 -y     -- see formats available with current version of nasm installed
## nasm -f elf64 -F dwarf swap.asm -o swap.o -g
nasm -f elf64 swap.asm -o swap.o -g
gcc -m64 -no-pie -g swap.o -o swap
