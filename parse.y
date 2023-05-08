%{
	#include <stdio.h>
	#include <stdbool.h>
	
	extern int yylineno;
	bool fl = 0;
		
	extern FILE* yyin;

	void yyerror(const char *str) {
		printf("not ok (%d: %s)\n", yylineno, str);
		fl = 1;
	}
%}


%start st
%token START FINISH IF ELSE WHILE RETURN PRINT INC DEC SAL SAR XOR NEG OR AND ADD SUB MUL DIV MOD NEQ EQ MORE LESS NUMBER VAR


%%
EXPR:
	;

st:
	| START commands FINISH
	;

commands:
	| commands command
	;

command:
	| '!'
	| 
	;

%%


int main(int argc, char* argv[]){
    yyin = fopen(argv[1], "r");
    yyparse();
	if (fl == 0) printf("ok\n");
	fclose(yyin);
}