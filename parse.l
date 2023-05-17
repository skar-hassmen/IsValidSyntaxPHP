%{
    #include "y.tab.h"
%}


%option yylineno
%option noyywrap


%%
"<?php"						return START;
"?>"						return FINISH;
"if"						return IF;
"else"						return ELSE;
"function"					return FUNC;
"foreach"					return FOREACH;
"for"						return FOR;
"while"						return WHILE;
"return"					return RETURN;
"print"						return PRINT;
"as"						return AS;
"break"						return BREAK;
"case"						return CASE;
"continue"					return CONTINUE;
"default"					return DEFAULT;
"echo"						return ECHO;
"switch"					return SWITCH;



"xor"                       return XOR_STR;
"and"                       return AND_STR;
"or"                        return OR_STR;

"++"						return INC;
"--"						return DEC;

"+="                        return ADD_EQ;
"-="                        return SUB_EQ;
"**="                       return MUMU_EQ;
"*="                        return MUL_EQ;
"%="                        return MOD_EQ;
"/="                        return DIV_EQ;
"<<="                       return SAL_EQ;
">>="                       return SAR_EQ;
"|="                        return OR_EQ;
"&="                        return AND_EQ;
"^="                        return XOR_EQ;
".="                        return POINT_EQ;

"<<"						return SAL;
">>"						return SAR;
"^"							return XOR;
"~"							return NEG;
"&&"                        return ANDAND;
"||"                        return OROR;
"??"                        return QUESQUEST;
"|"							return OR;
"&"							return AND;
"+"							return ADD;
"-"							return SUB;
"**"                        return MUMU;
"*"							return MUL;
"/"							return DIV;
"%"							return MOD;
">="                        return MORE_EQ;
"<="                        return LESS_EQ;
"==="                       return EQEQEQ;
"=="                        return EQEQ;
">"							return MORE;
"<"							return LESS;
"="							return EQ;
"."                         return POINT;
"!"                         return ANSWER;

"$"							return DOLLAR;

[0-9]+						return NUMBER;
[a-zA-Z_][a-zA-Z0-9_]*		return NAME;
[-{};()=<>+*/%!?,]			return *yytext;
[ \t\r\n]
%%