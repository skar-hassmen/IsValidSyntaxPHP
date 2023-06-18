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


%start ts
%token START FINISH DECLARE DO GOTO_TOKEN TICKS_TOKEN ENCODIND_TOKEN DOUBLE_POINT NOEQEQ NOEQ ELSEIF VALUE_STRING_SCREEN SINGLE_VALUE_STRING_SCREEN SINGLE_VALUE_STRING GLOBAL_TOKEN EXIT_TOKEN VALUE_STRING FUNC ARRAY PUBLIC_C NEW_C ARROW_CLASS PROTECTED_C PRIVATE_C STATIC_C CONST_C CLASS READ_ONLY EXTENDS ARROW INCLUDE REQUIRE REQUIRE_ONCE NULL_TOKEN SQUARE_OPEN SQUARE_CLOSE TRUE_TOKEN FALSE_TOKEN IF ELSE FOREACH FOR WHILE RETURN PRINT AS XOR_STR AND_STR OR_STR INC DEC ADD_EQ SUB_EQ MUMU_EQ MUL_EQ MOD_EQ DIV_EQ SAL_EQ SAR_EQ OR_EQ AND_EQ XOR_EQ POINT_EQ SAL SAR XOR NEG ANDAND OROR QUESQUEST OR AND ADD SUB MUMU MUL DIV MOD MORE_EQ LESS_EQ EQEQEQ EQEQ MORE LESS EQ POINT ANSWER DOLLAR NUMBER NAME BREAK CASE CONTINUE DEFAULT ECHO SWITCH 

%%
ts:
	START st FINISH
	;

st:
	| st body 
	;

body:
	command
	;

command:
	expr ';'
	| func
	| compare
	| loop
	| switch
	| operator
	| class
	;


class:
	readonly CLASS NAME extend '{' class_body '}'
	;

readonly:
	| READ_ONLY
	;

extend:
	| EXTENDS NAME
	;

class_body:
	| class_body some_class
	;

some_class:
	body_fields
	| body_methods
	;

body_methods:
	point1 point2 func
	| point2 point1 func
	;

body_fields:
	point1 point2 expr ';'
	| point2 point1 expr ';'
	| CONST_C NAME EQ right_expr ';'
	;

point1:
	| PUBLIC_C
	| PROTECTED_C
	| PRIVATE_C
	;

point2:
	| STATIC_C
	;

operator:
	return
	| break
	| continue
	| declare
	| echo
	| include
	| exit
	| goto
	| label
	;

goto:
	GOTO_TOKEN NAME ';'

label:
	NAME ':'

declare:
	DECLARE '(' TICKS_TOKEN EQ NUMBER ')' '{' block '}'
	| DECLARE '(' ENCODIND_TOKEN EQ quote_string ')' '{' block '}'
	| DECLARE '(' TICKS_TOKEN EQ NUMBER ')' ';'
	| DECLARE '(' ENCODIND_TOKEN EQ quote_string ')' ';'
	;

include:
	INCLUDE quote_string ';'
	| REQUIRE quote_string ';'
	| REQUIRE_ONCE quote_string ';'
	| INCLUDE '(' quote_string ')' ';'
	| REQUIRE '(' quote_string ')' ';'
	| REQUIRE_ONCE '(' quote_string ')' ';'
	;

quote_string:
	VALUE_STRING
	| SINGLE_VALUE_STRING
	| VALUE_STRING_SCREEN
	| SINGLE_VALUE_STRING_SCREEN
	;

return:
	RETURN right_expr ';'
	| RETURN ';'
	| RETURN quote_string ';'
	;

break:
	BREAK ';'
	| BREAK NUMBER ';'
	;

continue:
	CONTINUE ';'
	;

exit:
	EXIT_TOKEN right_expr ';'
	| EXIT_TOKEN ';'
	;

echo:
	ECHO right_expr ';'
	| ECHO quote_string ';'
	;

point_and_comma:
	| ';'	


func:
	FUNC NAME '(' args_and_type ')' ret_type '{' block '}'
	| prototype_for_arg point_and_comma
	;

block:
	| block command
	;
	
ret_type:
	| DOUBLE_POINT NAME
	;

switch:
	SWITCH '(' right_expr ')' '{' switch_body '}'
	;
switch_body:
	cases default
	;
cases:
	| cases case
	;

value_case:
	NUMBER
	| quote_string
	| NAME
	;

case:
	CASE value_case DOUBLE_POINT block
	;
default:
	| DEFAULT DOUBLE_POINT block
	;
	
compare:
	IF '(' expr_zero ')' '{' block '}' else
	| IF '(' expr_zero ')' command else
	| IF '(' expr_zero ')' ';'
	;

else:
	| ELSEIF '(' expr_zero ')' '{' block '}' else
	| ELSEIF '(' expr_zero ')' command else
	| ELSE '{' block '}'
	| ELSE command
	;
	
loop:
	for
	| while
	| foreach
	| do
	;

for:
	FOR '(' expr_zero ';' expr_zero ';' expr_zero ')' '{' block '}'
	| FOR '(' expr_zero ';' expr_zero ';' expr_zero ')' command
	| FOR '(' expr_zero ';' expr_zero ';' expr_zero ')' ';'
	;

do:
	DO '{' block '}' WHILE '(' expr_zero ')' ';'
	| DO command WHILE '(' expr_zero ')' ';'
	;

while:
	WHILE '(' expr_zero ')' '{' block '}'
	| WHILE '(' expr_zero ')' command
	| WHILE '(' expr_zero ')' ';'
	;

iter:
	left_expr
	| array
	| prototype_for_arg
	;

foreach:
	FOREACH '(' iter AS expr_foreach ')' '{' block '}'
	| FOREACH '(' iter AS expr_foreach ')' command
	| FOREACH '(' iter AS expr_foreach ')' ';'
	;

expr_foreach:
	left_expr
	| left_expr ARROW left_expr
	;

expr_zero:
	expr
	| right_expr
	;

expr:
	| left_expr
	| left_expr EQ right_expr
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
	| left_expr EQ array
	| left_expr EQ NEW_C prototype_for_arg
	;
	

array:
	ARRAY '(' block_array ')'
	| SQUARE_OPEN block_array SQUARE_CLOSE
	;

block_array:
	| block_array ',' block_array
	| key_array ARROW value_array
	| value_array
	; 


value_array:
	key_array
	| array
	| right_expr
	;

key_array:
	NEG NUMBER
	| right_expr
	;

global_args:
	global_args ',' left_expr
	| left_expr
	;

left_expr:
	dec_inc
	| point2 DOLLAR NAME
	| DOLLAR NAME get_elem_array ARROW_CLASS right_part
	| DOLLAR NAME get_elem_array
	| NAME DOUBLE_POINT DOUBLE_POINT right_part
	| GLOBAL_TOKEN global_args
	;

right_part:
	DOLLAR prototype_for_arg
	| prototype_for_arg
	| NAME
	;

right_expr:
	'(' right_expr ')'
	| '(' NAME ')' right_expr
	| ANSWER right_expr
	| AND right_expr
	| NEG right_expr
	| SUB right_expr
	| ADD right_expr
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
	| right_expr NOEQEQ right_expr
	| right_expr NOEQ right_expr
	| right_expr XOR_STR right_expr
	| right_expr AND_STR right_expr
	| right_expr OR_STR right_expr
	| right_expr '?' right_expr DOUBLE_POINT right_expr
	| NUMBER
	| NAME
	| NULL_TOKEN
	| TRUE_TOKEN
	| FALSE_TOKEN
	| left_expr
	| array
	| prototype_for_arg
	| quote_string
	;


inition_value_arg:
	SUB NUMBER
	| ADD NUMBER
	| NUMBER
	| NULL_TOKEN
	| TRUE_TOKEN
	| FALSE_TOKEN
	| quote_string
	| NAME
	;

args_and_type:
	| args_and_type ',' args_and_type
	| NAME left_expr
	| left_expr EQ inition_value_arg
	| left_expr
	| AND args_and_type
	;

args:
	| args ',' args
	| right_expr
	;

prototype_for_arg:
	NAME '(' args ')'
	;

key_array_get_elem_array:
	| key_array
	;

get_elem_array:
	| SQUARE_OPEN key_array_get_elem_array SQUARE_CLOSE get_elem_array
	| '{' key_array_get_elem_array '}' get_elem_array
	;

value_dec_inc:
	DOLLAR NAME get_elem_array
	| prototype_for_arg
	;

dec_inc:
	| INC value_dec_inc
	| value_dec_inc INC
	| DEC value_dec_inc
	| value_dec_inc DEC
	;
%%


int main(int argc, char* argv[]){
	if (argc != 2) {
		return 1;
	}

    yyin = fopen(argv[1], "r");
    yyparse();
	if (fl == 0) printf("ok\n");
	fclose(yyin);
}