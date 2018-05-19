all:
	nasm -O0 -f elf64 -o jmps.o jmps.asm 
	#convert assembly to object
	ld -static --fatal-warnings jmps.o -o jmps

