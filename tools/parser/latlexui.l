%option nounistd
%option outfile="latlexui.c" header-file="latlexui.h"
%option warn nodefault
%option reentrant noyywrap never-interactive
%option bison-bridge bison-locations
%option yylineno
%option extra-type="struct lex_state *"
%option nounput

%{
/*********************************************************************************
* The MIT License (MIT)                                                          *
*                                                                                *
* Copyright (c) Latino - Lenguaje de Programacion                                *
*                                                                                *
* Permission is hereby granted, free of charge, to any person obtaining          *
* a copy of this software and associated documentation files (the "Software"),   *
* to deal in the Software without restriction, including without limitation      *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,       *
* and/or sell copies of the Software, and to permit persons to whom the Software *
* is furnished to do so, subject to the following conditions:                    *
*                                                                                *
* The above copyright notice and this permission notice shall be included in     *
* all copies or substantial portions of the Software.                            *
*                                                                                *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS        *
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL        *
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER     *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  *
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN      *
* THE SOFTWARE.                                                                  *
**********************************************************************************/

#include <string.h>
#include <stdlib.h>

#include "latast.h"
#include "latparse.h"
#include "latastui.h"
#include "latparseui.h"

#define YY_NO_INPUT
#define YYBISON 1

#define YY_USER_ACTION \
    yylloc->file_name = filename;\
    yylloc->first_line = yylloc->last_line+1; \
    yylloc->first_column = yylloc->last_column+1; \
    for(int i = 0; yytext[i] != '\0'; i++) { \
        if(yytext[i] == '\n') { \
            yylloc->last_line++; \
            yylloc->last_column = 0; \
        } \
        else { \
            yylloc->last_column++; \
        } \
    }

#if YYBISON
union YYSTYPE;
extern int yylex (YYSTYPE * yylval_param,YYLTYPE * yylloc_param ,yyscan_t yyscanner);
#endif

%}

%%

 /* palabras reservadas */
"INICIO"                                { return INICIO; }
"FIN"                                   { return FIN; }
"FORMULARIO"                            { return FORMULARIO; }
"OBJ_PIC"                               { return OBJ_PIC; }
"OBJ_BTN"                               { return OBJ_BTN; }
"OBJ_TXT"                               { return OBJ_TXT; }
"sub"                                   { return SUB; }

 /* propiedades */
"_estilo_border"                        { return _ESTILO_BORDER; }
"_titulo"                               { return _TITULO; }
"_ancho"                                { return _ANCHO; }
"_alto"                                 { return _ALTO; }
"_horizontal"                           { return _HORIZONTAL; }
"_vertical"                             { return _VERTICAL; }
"_btn_max"                              { return _BTN_MAX; }
"_btn_min"                              { return _BTN_MIN; }
"_mostrar_barra"                        { return _MOST_BARR; }
"_posicion_inicial"                     { return _POS_INI; }
"_index"                                { return _INDEX; }
"_cancelar"                             { return _CANCELAR; }
"_defecto"                              { return _DEFECTO; }
"_imagen"                               { return _IMAGEN; }
"_auto_ajuste"                          { return _AUTO_AJUSTE; }

 /* names */
[_A-Z]*                                 { yylval->node = latA_var(yytext, yylloc->first_line, yylloc->first_column, 1); return IDENTIFICADOR; }
[_a-zA-Z][_a-zA-Z0-9]*                  { yylval->node = latA_var(yytext, yylloc->first_line, yylloc->first_column, 0); return IDENTIFICADOR; }
[\n\r]                                          { ; }  /* ignora saltos de linea */
[\t]+                                           { ; }  /* ignora espacios en blanco y tabuladores */
.                                               { ; }  /* ignora caracteres incorrectos */

%%