all: l b g

l: 
	lex parse.l

b:
	bison -y -d parse.y

g:
	gcc lex.yy.c y.tab.c