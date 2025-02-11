%{
#include<stdio.h>
#include<stdlib.h>
int ln = 1;
%}

%%
"#include"|"#define" {printf("PREPROCCESSOR DIRECTIVE: %s\n", yytext);
"stdio.h"|"stdlib.h"|"math.h"|"string.h" {printf("HEADER FILE: %s\n", yytext);
"main"|"if"|"else"|"for"|"do"|"while"|"printf" {printf("KEYWORDS: %s\n", yytext);
[a-zA-Z][a-zA-Z0-9_]* {printf("IDENTIFIER: %s\n", yytext);
%%

int yywrap(void) {}

int main(int argc, char* argv[])
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
           perror("fopen");
           return 1;
        }
        yyin = file;
    }
    yylex();
    return 0;
} 