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

/* bison -y -oparse.c parse.y */
#define YYERROR_VERBOSE 1
#define YYDEBUG 1
#define YYENABLE_NLS 1
#define YYLEX_PARAM &yylval, &yylloc

#include <stddef.h>

#include "latino.h"
#include "latast.h"
#include "latlex.h"
#include "latastui.h"
#include "latlexui.h"

#ifndef LAT_ERROR_FMT
#define LAT_ERROR_FMT "%s:%d:%d: %s\n"
#endif

#ifdef __linux
#include <libintl.h>
#define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#endif

int yyerror(struct YYLTYPE *yylloc_param, void *scanner, struct ast **root, const char *s);
int yylex (YYSTYPE * yylval_param,YYLTYPE * yylloc_param ,yyscan_t yyscanner);

%}

%output "latparseui.c"
%defines "latparseui.h"

%locations
%define api.pure
%lex-param {void *scanner}
%parse-param {ast **root}
%parse-param {void *scanner}

/* declare tokens */
%token <node> IDENTIFICADOR

%token
    INICIO
    FIN
    FORMULARIO
    OBJ_PIC
    OBJ_BTN
    OBJ_TXT
    sub

%token
    _ESTILO_BORDER
    _TITULO
    _ANCHO
    _ALTO
    _HORIZONTAL
    _VERTICAL
    _BTN_MAX
    _BTN_MIN
    _MOST_BARR
    _POS_INI
    _INDEX
    _CANCELAR
    _DEFECTO
    _IMAGEN
    _AUTO_AJUSTE

%type <node> formulario_form
%type <node> listado_declaraciones declaraciones listado_objetos
%type <node> propiedades_general propiedades_form propiedades_obj
%type <node> objeto objetos

%start programa

%%

programa:
    { /* empty */
        *root = NULL;
    }
    | listado_declaraciones { *root = $1; }
    ;

listado_declaraciones:
    declaraciones listado_declaraciones {
        if($2){
            $$ = latA_nodo(NODO_BLOQUE, $1, $2, @1.first_line, @1.first_column);
        }
    }
    | declaraciones {
        if($1){
          $$ = latA_nodo(NODO_BLOQUE, $1, NULL, @1.first_line, @1.first_column);
        }
    }
    | error listado_declaraciones { yyerrok; yyclearin;}
    ;

declaraciones:
    formulario_form
    ;

listado_objetos:
    OBJ_PIC
    | OBJ_BTN
    | OBJ_TXT
    ;

formulario_form:
    INICIO FORMULARIO IDENTIFICADOR propiedades_form objetos FIN FORMULARIO {
        $$ = latA_UI_formulario(NODO_FORMULARIO, $3, $4, $5);
    }
    ;

objetos:
    objeto
    | objetos objeto
    ;

objeto:
    INICIO listado_objetos IDENTIFICADOR propiedades_obj FIN {
        $$ = latA_UI_objeto(NODO_OBJETO, $3, $4);
    }
    ;

propiedades_general:
    | _ANCHO
    | _ALTO
    | _HORIZONTAL
    | _VERTICAL
    | _INDEX
    | _TITULO
    ;

propiedades_form:
    _ESTILO_BORDER
    | _BTN_MAX
    | _BTN_MIN
    | _MOST_BARR
    | _POS_INI
    | propiedades_general
    ;

propiedades_obj:
    _CANCELAR
    | _DEFECTO
    | propiedades_general
    | _IMAGEN
    | _AUTO_AJUSTE
    ;

%%

//se define para analisis sintactico (bison)
int yyerror(struct YYLTYPE *yylloc_param, void *scanner, struct ast **root,
const char *s) {
  if(!parse_silent){
      fprintf(stderr, LAT_ERROR_FMT, yylloc_param->file_name,
        yylloc_param->first_line, yylloc_param->first_column,  s);
  }
  return 0;
}