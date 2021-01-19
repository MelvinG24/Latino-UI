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

/*********************************************************************************
*   Autor: Fundación Lenguaje Latino                                             *
*                                                                                *
* Website: Oficial       <https://lenguajelatino.org>                    2015-on *
* Website: Manual Latino <https://manual.lenguajelatino.com>             2020-on *
*    Repo: GitHub        <https://github.com/MelvinG24/Latino-UI>        2021-on *
*                                                                                *
*    Desc: Librería gráfica para Latino                                          *
**********************************************************************************/

#include "lat_ui_compat.h"

#define LIB_UI_NAME "ui"

static void ui_winProc(lat_mv *mv) {
    lat_objeto *l = latC_desapilar(mv);
    lat_objeto *k = latC_desapilar(mv);
    lat_objeto *j = latC_desapilar(mv);
    lat_objeto *i = latC_desapilar(mv);
    lat_objeto *h = latC_desapilar(mv);
    lat_objeto *g = latC_desapilar(mv);
    lat_objeto *f = latC_desapilar(mv);
    lat_objeto *e = latC_desapilar(mv);
    lat_objeto *d = latC_desapilar(mv);
    lat_objeto *c = latC_desapilar(mv);
    lat_objeto *b = latC_desapilar(mv);
    lat_objeto *a = latC_desapilar(mv);
    int *lpParam        = (int)latC_checar_numerico(mv, l);
    int *hInstance      = (int)latC_checar_numerico(mv, k);
    int *hMenu          = (int)latC_checar_numerico(mv, j);
    int *hWndParent     = (int)latC_checar_numerico(mv, i);
    int *nHeight        = (int)latC_checar_numerico(mv, h);
    int *nWidth         = (int)latC_checar_numerico(mv, g);
    int *y              = (int)latC_checar_numerico(mv, f);
    int *x              = (int)latC_checar_numerico(mv, e);
    int *dwStyle        = (int)latC_checar_numerico(mv, d);
    char *lpWindowName  = latC_checar_cadena(mv, b);
    int *lpClassName    = (int)latC_checar_numerico(mv, a);

    HWND hwnd = CreateWindowEx(0,"lpWindowName","Learn to program", WS_OVERLAPPEDWINDOW,
    CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
    NULL, NULL, 3, NULL);
    if (hwnd == NULL) {
        return 0;
    }
    ShowWindow(hwnd, 5);
}

//Mensajes
static void ui_messagebox(lat_mv *mv) {
    lat_objeto *o = latC_desapilar(mv);
    int *ico=0, *btn=0, cant = (int)latC_checar_numerico(mv, o);
    char *msg="\0", *tl="UI Mensaje Latino";
    printf(">>> %d\n", cant);
    if (cant == 1) {
        msg = latC_checar_cadena(mv, latC_desapilar(mv));
    } else if (cant == 2) {
        tl  = latC_checar_cadena(mv, latC_desapilar(mv));
        msg = latC_checar_cadena(mv, latC_desapilar(mv));
    } else if (cant == 3) {
        btn = (int)latC_checar_numerico(mv, latC_desapilar(mv));
        tl  = latC_checar_cadena(mv, latC_desapilar(mv));
        msg = latC_checar_cadena(mv, latC_desapilar(mv));
    } else if (cant == 4) {
        ico = (int)latC_checar_numerico(mv, latC_desapilar(mv));
        btn = (int)latC_checar_numerico(mv, latC_desapilar(mv));
        tl  = latC_checar_cadena(mv, latC_desapilar(mv));
        msg = latC_checar_cadena(mv, latC_desapilar(mv));
    } else {
        latC_error(mv, "Error, minima cantidad de argumentos invalido");
    }
    int m = MessageBox(ico,msg,tl,btn);
    lat_objeto *msgbox = latC_crear_numerico(mv, m);
    latC_apilar(mv, msgbox);
}

static void ui_flash(lat_mv *mv) {
    FlashWindow(0,true);
}

static const lat_CReg lib_ui[] = {
    {"ventana", ui_winProc, 0},
    {"mensaje", ui_messagebox, FUNCION_VAR_ARGS},
    {"flash", ui_flash, 0},
    {NULL, NULL}};

LATINO_API void latC_abrir_liblatino_ui(lat_mv *mv) {
    latC_abrir_liblatino(mv, LIB_UI_NAME, lib_ui);
}