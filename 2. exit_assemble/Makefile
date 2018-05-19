all:
	nasm -O0 -f elf64 -o fin.o fin.asm 
	nasm -O0 -f elf64 -o fin2.o fin2.asm 
	#convert assembly to object
	ld -static --fatal-warnings fin.o -o fin
	ld -static --fatal-warnings fin2.o -o fin2

