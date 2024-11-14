%{
#include <stdio.h>
%}

%%
"if"|"else" {printf("KEYWORD: %s\n", yytext);}
[0-9]+ {printf("NUMBER: %s", yytext);}
[a-zA-Z_][a-zA-Z0-9_]* {printf("IDENTIFIER: %s\n", yytext);}
[+\-*/=] {printf("OPERATOR: %s\n", yytext);}
[ \t\n] {/*ignore whitespaces*/}
. {printf("UNKNOWN CHARACTER\n");}

%%
int yywrap(){}

int main ()
{
yylex();
return 0;
}