all:
	nasm -O0 -f elf64 -o syscall1.o syscall1.asm 
	nasm -O0 -f elf64 -o syscall2.o syscall2.asm 
	#convert assembly to object
	ld syscall1.o -o syscall1
	ld syscall2.o -o syscall2


