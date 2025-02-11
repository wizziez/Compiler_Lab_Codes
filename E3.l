%{
#include<stdio.h>
#include<string.h>
int i=0;
%}

%%
 printf("What is your name?\n");
([a-zA-Z0-9])* {i++;}
"\n" {printf("%d\n",i);i=0;}
%%

int yywrap(void){}

int main(){
yylex();
return 0;
}