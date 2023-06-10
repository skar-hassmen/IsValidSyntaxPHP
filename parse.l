%{
    #include "y.tab.h"
%}


%option yylineno
%option noyywrap


%%
"<?php"						return START;
"?>"						return FINISH;
"elseif"                    return ELSEIF;
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
"array"                     return ARRAY;
"include"                   return INCLUDE;
"require"                   return REQUIRE;
"require_once"              return REQUIRE_ONCE;
"class"                     return CLASS;
"extends"                   return EXTENDS;
"readonly"                  return READ_ONLY;
"static"                    return STATIC_C;
"const"                     return CONST_C;
"public"                    return PUBLIC_C;
"protected"                 return PROTECTED_C;
"private"                   return PRIVATE_C;
"new"                       return NEW_C;

"null"                      return NULL_TOKEN;
"true"                      return TRUE_TOKEN;
"false"                     return FALSE_TOKEN;

"xor"                       return XOR_STR;
"and"                       return AND_STR;
"or"                        return OR_STR;

"global"                    return GLOBAL_TOKEN;
"exit"                      return EXIT_TOKEN;

"->"                        return ARROW_CLASS;
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
"=>"                        return ARROW;
"==="                       return EQEQEQ;
"=="                        return EQEQ;
"!="                        return NOEQ;
">"							return MORE;
"<"							return LESS;
"="							return EQ;
"."                         return POINT;
"!"                         return ANSWER;
":"                         return DOUBLE_POINT;
"["                         return SQUARE_OPEN;
"]"                         return SQUARE_CLOSE;

"$"							return DOLLAR;

\"[^\"]*\\.*\"              return VALUE_STRING_SCREEN;
\'[^']*\\.*'                return SINGLE_VALUE_STRING_SCREEN;

\"[^\"]*\"                  return VALUE_STRING;
\'[^']*'                    return SINGLE_VALUE_STRING;

\/\*[^*\/]*\*\/

\/\/[^\n]*

[0-9]+						return NUMBER;
[a-zA-Z_][a-zA-Z0-9_]*		return NAME;
[-{};()=<>+*/%!?,:\'\"]		return *yytext;
[ \t\r\n]
%%