build: main.c
	gcc -o tema main.c -ll

main.c: main.l
	flex -o main.c main.l
