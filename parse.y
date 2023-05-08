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
st:
	| START body FINISH
	;
	
body:
	//| class
	| body
	| func
	| struct
	| block
	;
/*	
class:
	CLASS name '{' cl_funcs cl_vars '}'
	;*/
	
func:
	FUNC NAME '(' args ')' '{' block '}'
	| prototype
	;
prototype:
	FUNC NAME '(' args ')' ';'
	;

struct:
	STRUCT NAME '{' st_vars '}'
	;

block:
	| block command
	;
	
command: 
	| vars		///////////////////////
	| expr		///////////////////////
	| compare
	| loop
	| operator
	| base_func	/////////////////////////////
	| switch
	;
	
oper_args:
	prototype
	| var
	| expr
	;
	
operator:
	return
	| break
	| continue
	| echo
	;
return:
	RETURN oper_args ';'
	| RETURN ';'
	;
break:
	BREAK ';'
	;
continue:
	CONTINUE ';'
	;
echo:
	ECHO oper_args ';'
	| ECHO '"' string '"' ';'
	| ECHO '\'' string '\'' ';'
	;
	
switch:
	SWITCH '(' var ')' '{' switch_body '}'
	;
switch_body:
	cases default
	;
cases:
	| cases case
	;
case:
	CASE NUMBER ':' block
	;
default:
	| DEFAULT ':' block
	;
	
compare:
	IF '(' expr ')' '{' block '}' else
	| IF '(' expr ')' command else
	| IF '(' expr ')' ';'
	;
else:
	ELSE '{' block '}'
	| ELSE command
	|
	;
	
loop:
	for
	| while
	| foreach
	;
for:
	FOR '(' expr ';' expr ';' expr ')' '{' block '}'
	| FOR '(' expr ';' expr ';' expr ')' command
	| FOR '(' expr ';' expr ';' expr ')' ';'
	;
while:
	WHILE '(' expr ')' '{' block '}'
	| WHILE '(' expr ')' command
	| WHILE '(' expr ')' ';'
	;	
foreach:
	FOREACH '(' vars AS vars ')' '{' block '}'
	| FOREACH '(' vars AS vars ')' command
	| FOREACH '(' vars AS vars ')' ';'
	;

%%


int main(int argc, char* argv[]){
    yyin = fopen(argv[1], "r");
    yyparse();
	if (fl == 0) printf("ok\n");
	fclose(yyin);
}