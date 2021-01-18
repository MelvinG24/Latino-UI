/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_LATPARSEUI_H_INCLUDED
# define YY_YY_LATPARSEUI_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENTIFICADOR = 258,
    INICIO = 259,
    FIN = 260,
    FORMULARIO = 261,
    OBJ_PIC = 262,
    OBJ_BTN = 263,
    OBJ_TXT = 264,
    sub = 265,
    _ESTILO_BORDER = 266,
    _TITULO = 267,
    _ANCHO = 268,
    _ALTO = 269,
    _HORIZONTAL = 270,
    _VERTICAL = 271,
    _BTN_MAX = 272,
    _BTN_MIN = 273,
    _MOST_BARR = 274,
    _POS_INI = 275,
    _INDEX = 276,
    _CANCELAR = 277,
    _DEFECTO = 278,
    _IMAGEN = 279,
    _AUTO_AJUSTE = 280
  };
#endif
/* Tokens.  */
#define IDENTIFICADOR 258
#define INICIO 259
#define FIN 260
#define FORMULARIO 261
#define OBJ_PIC 262
#define OBJ_BTN 263
#define OBJ_TXT 264
#define sub 265
#define _ESTILO_BORDER 266
#define _TITULO 267
#define _ANCHO 268
#define _ALTO 269
#define _HORIZONTAL 270
#define _VERTICAL 271
#define _BTN_MAX 272
#define _BTN_MIN 273
#define _MOST_BARR 274
#define _POS_INI 275
#define _INDEX 276
#define _CANCELAR 277
#define _DEFECTO 278
#define _IMAGEN 279
#define _AUTO_AJUSTE 280

/* Value type.  */

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif



int yyparse (ast **root, void *scanner);

#endif /* !YY_YY_LATPARSEUI_H_INCLUDED  */
