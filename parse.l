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
for							return FOR;
foreach						return FOREACH;
while						return WHILE;
return						return RETURN;
print						return PRINT;
as							return AS;

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

"$"							return DOLLAR;

[0-9]+						return NUMBER;
[a-zA-Z_][a-zA-Z0-9_]*		return NAME;
[-{};()=<>+*/%!?]			return *yytext;
[ \t\r\n]
%%