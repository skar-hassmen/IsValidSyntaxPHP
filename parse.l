%{
    #include "parse.tab.h"
%}


%option yylineno
%option noyywrap


%%
"<?php"						return START;
"?>"						return FINISH;
if							return IF;
else						return ELSE;
while						return WHILE;
return						return RETURN;
print						return PRINT;

"++"						return INC;
"--"						return DEC;
"<<"						return SAL;
">>"						return SAR;
"^"							return XOR;
"~"							return NEG;
"|"							return OR;
"&"							return AND;
"+"							return ADD;
"-"							return SUB;
"*"							return MUL;
"/"							return DIV;
"%"							return MOD;
">"							return MORE;
"<"							return LESS;
"="							return EQ;

[0-9]+						return NUMBER;
[a-zA-Z_][a-zA-Z0-9_]*		return VAR;
[-{};()=<>+*/%!?]			return *yytext;
[ \t\r\n]
%%