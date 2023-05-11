/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    START = 258,                   /* START  */
    FINISH = 259,                  /* FINISH  */
    IF = 260,                      /* IF  */
    ELSE = 261,                    /* ELSE  */
    FOREACH = 262,                 /* FOREACH  */
    FOR = 263,                     /* FOR  */
    WHILE = 264,                   /* WHILE  */
    RETURN = 265,                  /* RETURN  */
    PRINT = 266,                   /* PRINT  */
    AS = 267,                      /* AS  */
    XOR_STR = 268,                 /* XOR_STR  */
    AND_STR = 269,                 /* AND_STR  */
    OR_STR = 270,                  /* OR_STR  */
    INC = 271,                     /* INC  */
    DEC = 272,                     /* DEC  */
    ADD_EQ = 273,                  /* ADD_EQ  */
    SUB_EQ = 274,                  /* SUB_EQ  */
    MUMU_EQ = 275,                 /* MUMU_EQ  */
    MUL_EQ = 276,                  /* MUL_EQ  */
    MOD_EQ = 277,                  /* MOD_EQ  */
    DIV_EQ = 278,                  /* DIV_EQ  */
    SAL_EQ = 279,                  /* SAL_EQ  */
    SAR_EQ = 280,                  /* SAR_EQ  */
    OR_EQ = 281,                   /* OR_EQ  */
    AND_EQ = 282,                  /* AND_EQ  */
    XOR_EQ = 283,                  /* XOR_EQ  */
    POINT_EQ = 284,                /* POINT_EQ  */
    SAL = 285,                     /* SAL  */
    SAR = 286,                     /* SAR  */
    XOR = 287,                     /* XOR  */
    NEG = 288,                     /* NEG  */
    ANDAND = 289,                  /* ANDAND  */
    OROR = 290,                    /* OROR  */
    QUESQUEST = 291,               /* QUESQUEST  */
    OR = 292,                      /* OR  */
    AND = 293,                     /* AND  */
    ADD = 294,                     /* ADD  */
    SUB = 295,                     /* SUB  */
    MUMU = 296,                    /* MUMU  */
    MUL = 297,                     /* MUL  */
    DIV = 298,                     /* DIV  */
    MOD = 299,                     /* MOD  */
    MORE_EQ = 300,                 /* MORE_EQ  */
    LESS_EQ = 301,                 /* LESS_EQ  */
    EQEQEQ = 302,                  /* EQEQEQ  */
    EQEQ = 303,                    /* EQEQ  */
    MORE = 304,                    /* MORE  */
    LESS = 305,                    /* LESS  */
    EQ = 306,                      /* EQ  */
    POINT = 307,                   /* POINT  */
    ANSWER = 308,                  /* ANSWER  */
    DOLLAR = 309,                  /* DOLLAR  */
    NUMBER = 310,                  /* NUMBER  */
    NAME = 311                     /* NAME  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define START 258
#define FINISH 259
#define IF 260
#define ELSE 261
#define FOREACH 262
#define FOR 263
#define WHILE 264
#define RETURN 265
#define PRINT 266
#define AS 267
#define XOR_STR 268
#define AND_STR 269
#define OR_STR 270
#define INC 271
#define DEC 272
#define ADD_EQ 273
#define SUB_EQ 274
#define MUMU_EQ 275
#define MUL_EQ 276
#define MOD_EQ 277
#define DIV_EQ 278
#define SAL_EQ 279
#define SAR_EQ 280
#define OR_EQ 281
#define AND_EQ 282
#define XOR_EQ 283
#define POINT_EQ 284
#define SAL 285
#define SAR 286
#define XOR 287
#define NEG 288
#define ANDAND 289
#define OROR 290
#define QUESQUEST 291
#define OR 292
#define AND 293
#define ADD 294
#define SUB 295
#define MUMU 296
#define MUL 297
#define DIV 298
#define MOD 299
#define MORE_EQ 300
#define LESS_EQ 301
#define EQEQEQ 302
#define EQEQ 303
#define MORE 304
#define LESS 305
#define EQ 306
#define POINT 307
#define ANSWER 308
#define DOLLAR 309
#define NUMBER 310
#define NAME 311

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
