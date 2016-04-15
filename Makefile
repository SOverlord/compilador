all: clean fin run

fin: lex yacc bison
	gcc -w -o compilador lex.yy.c y.tab.c -ly -ll -lm

lex:
	lex scanner.l

yacc:
	yacc -d gramatica.y

bison:
	bison -d gramatica.y

run:
	./compilador prueba1.txt

git:
	$ git add .
	$ git add -A
	$ git commit -m "V4.0"
	$ git push origin master

clean:
	rm -rf *o compilador *.c gramatica.tab.* y.tab* reporte