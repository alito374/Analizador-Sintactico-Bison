%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

/* Definición de Tokens */
%token NUMBER
%left '+' '-'
%left '*' '/'

%%

/* Reglas Gramaticales */
input:
    /* vacío */
    | input line
;

line:
    '\n'
    | expr '\n' { printf("Sintaxis correcta. Resultado = %d\n", $1); }
;

expr:
    NUMBER          { $$ = $1; }
  | expr '+' expr   { $$ = $1 + $3; }
  | expr '-' expr   { $$ = $1 - $3; }
  | expr '*' expr   { $$ = $1 * $3; }
  | expr '/' expr   { 
                        if ($3 == 0) {
                            yyerror("Error: División por cero");
                            YYERROR;
                        } else {
                            $$ = $1 / $3; 
                        }
                    }
  | '(' expr ')'     { $$ = $2; }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error sintáctico: %s\n", s);
}

int main(void) {
    printf("Ingrese una expresión matemática:\n");
    return yyparse();
}