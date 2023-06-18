all: lex bison gcc

lex: 
	lex parse.l

bison:
	bison -y -d parse.y

gcc:
	gcc lex.yy.c y.tab.c


check: function test crackers

function:
	./a.out function.php

test:
	./a.out test.php

crackers:
	./a.out crackers.php

nano:
	./a.out nanoweb.php