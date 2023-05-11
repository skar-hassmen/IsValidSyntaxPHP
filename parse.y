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
%token START FINISH IF ELSE FOREACH FOR WHILE RETURN PRINT AS XOR_STR AND_STR OR_STR INC DEC ADD_EQ SUB_EQ MUMU_EQ MUL_EQ MOD_EQ DIV_EQ SAL_EQ SAR_EQ OR_EQ AND_EQ XOR_EQ POINT_EQ SAL SAR XOR NEG ANDAND OROR QUESQUEST OR AND ADD SUB MUMU MUL DIV MOD MORE_EQ LESS_EQ EQEQEQ EQEQ MORE LESS EQ POINT ANSWER DOLLAR NUMBER NAME 

%%
st:
	| st command 
	;

command:
	expr
	;

expr:
	left_expr EQ right_expr
	| left_expr ADD_EQ right_expr 
	| left_expr SUB_EQ right_expr 
	| left_expr MUMU_EQ right_expr 
	| left_expr MUL_EQ right_expr 
	| left_expr MOD_EQ right_expr 
	| left_expr DIV_EQ right_expr 
	| left_expr SAL_EQ right_expr 
	| left_expr SAR_EQ right_expr 
	| left_expr OR_EQ right_expr 
	| left_expr AND_EQ right_expr 
	| left_expr XOR_EQ right_expr 
	| left_expr POINT_EQ right_expr 
	;
	
left_expr:
	DOLLAR NAME
	;

right_expr:
	'(' right_expr ')'
	| right_expr EQ right_expr
	| right_expr SAL right_expr
	| right_expr SAR right_expr
	| right_expr XOR right_expr
	| right_expr OR right_expr
	| right_expr AND right_expr
	| right_expr ADD right_expr
	| right_expr SUB right_expr
	| right_expr MUMU right_expr
	| right_expr MUL right_expr
	| right_expr DIV right_expr
	| right_expr MOD right_expr
	| right_expr MORE right_expr
	| right_expr LESS right_expr
	| right_expr POINT right_expr
	| right_expr ANDAND right_expr
	| right_expr OROR right_expr
	| right_expr QUESQUEST right_expr
	| right_expr MORE_EQ right_expr
	| right_expr LESS_EQ right_expr
	| right_expr EQEQEQ right_expr
	| right_expr EQEQ right_expr
	| right_expr XOR_STR right_expr
	| right_expr AND_STR right_expr
	| right_expr OR_STR right_expr
	| SUB NUMBER
	| NUMBER
	| var
	;

var:
	left_expr
	| INC left_expr
	| left_expr INC
	| DEC left_expr
	| left_expr DEC
	| NEG left_expr
	| ANSWER left_expr
	| SUB left_expr
	;
%%


int main(int argc, char* argv[]){
    yyin = fopen("test.z", "r");
    yyparse();
	if (fl == 0) printf("ok\n");
	fclose(yyin);
}