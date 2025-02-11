%{
#include<stdio.h>
%}

%% 
  printf("Hello World!\n");
%%

int yywrap(void){
  return 1;
}

int main(){
  yylex();
  return 0;
}