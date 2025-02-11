%{

#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);

%}

%token ID
%token NUMBER
%left '+'
%left '(' ')'

%%

expr: expr '+' expr { printf("Result: %d\n", $1 + $3); $$ = $1 + $3; }
    | '(' expr ')' { $$ = $2; }
    | NUMBER { $$ = $1; }
    | ID { $$ = $1; }
    ;

%%

int main() {

printf("Enter an expression: \n");
yyparse();
return 0;

}
void yyerror(const char *s) {
fprintf(stderr, "Error: %s\n", s);
}

