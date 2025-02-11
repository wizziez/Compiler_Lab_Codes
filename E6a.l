%{
#include "E6.tab.h"
%}

%%

[0-9]+(\.[0-9]+)? { 
    yylval.dval = atof(yytext); 
    return NUMBER; 
}

"sin" { return SIN; }
"cos" { return COS; }
"tan" { return TAN; }
"log" { return LOG; }
"sqrt" { return SQRT; }

[+\-*/()] { return yytext[0]; }  // Operators and parentheses

[ \t] { /* Ignore whitespace */ }

\n { return '\n'; }  // Handle newlines

. { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
