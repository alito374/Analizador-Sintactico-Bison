%{
#include "parser.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t]       ; /* Ignorar espacios y tabulaciones */
\n          { return '\n'; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"("         { return '('; }
")"         { return ')'; }
.           { printf("Carácter no reconocido: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
} 
