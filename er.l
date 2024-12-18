%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
%}

%%
 [/][/][a-zA-Z0-9!#$%^&*]*[\n] { printf("Comment: %s\n",yytext); }
 [/][\*][a-zA-Z0-9!#$%^&*()_+{}|"<>?]*[\*][/] { printf("Comment: %s\n",yytext); }
 ["][a-zA-Z0-9!@#$%^&*()_+{}|"<>?]*["] { printf("Literal: %s\n",yytext); }
 [0-9]+ { printf("Integer: %s\n", yytext); }
 [0-9]*[.][0-9]+ { printf("Real number: %s\n", yytext); }
 "int"|"main"|"printf"|"scanf"|"for"|"return" { printf("Keyword: %s\n",yytext); }
 [a-zA-Z_$][a-zA-Z0-9_$]* { printf("iDENTIFIERS: %s\n",yytext); }
 [< >] { printf("Relational Operator: %s\n",yytext); }
 [< > = !][=] { printf(" Relational Operator: %s\n",yytext); }
 [+/-/*/\] { printf("Operator: %s\n",yytext); }
 [\[\]\{\}\(\)] { printf("Brackets: %s\n",yytext); }
 [,;] { printf("Punctuation: %s\n",yytext); }
 [ \t\n] { }
 . { printf("Unknown: %s\n",yytext); }

%%

int yywrap() {}

int main (int argc, char **argv) {
  if (argc>1) {
 FILE *file = fopen(argv[1], "r");
 if (!file) {
    perror("fopen");
    return EXIT_FAILURE;
      }
 yyin=file;
}
 yylex();
 return 0;

}