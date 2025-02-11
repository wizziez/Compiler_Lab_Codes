%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yylex();
void yyerror(const char *s);
%}

%union {
    double dval;
}

%token <dval> NUMBER
%type <dval> expr
%token SIN COS TAN LOG SQRT

%left '+' '-'
%left '*' '/'
%right UMINUS /* Unary Minus */

%%

calculate:
    calculate '\n'
  | calculate expr '\n' { printf("Result: %f\n", $2); }
  | /* empty rule */
;

expr:
    expr '+' expr { $$ = $1 + $3; }
  | expr '-' expr { $$ = $1 - $3; }
  | expr '*' expr { $$ = $1 * $3; }
  | expr '/' expr { 
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
  | '-' expr %prec UMINUS { $$ = -$2; }
  | '(' expr ')' { $$ = $2; }
  | SIN '(' expr ')' { $$ = sin($3); }
  | COS '(' expr ')' { $$ = cos($3); }
  | TAN '(' expr ')' { $$ = tan($3); }
  | LOG '(' expr ')' {
        if ($3 <= 0) {
            yyerror("Logarithm of non-positive number");
            $$ = 0;
        } else {
            $$ = log($3);
        }
    }
  | SQRT '(' expr ')' {
        if ($3 < 0) {
            yyerror("Square root of negative number");
            $$ = 0;
        } else {
            $$ = sqrt($3);
        }
    }
  | NUMBER { $$ = $1; }
;

%%

int main() {
    printf("Enter expressions to calculate (e.g., 2+3, sin(0.5)): \n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
