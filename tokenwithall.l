%{ 
#include <stdio.h> 
#include <stdlib.h> 
int line_cnt=1; 
%} 

%% 

[/][/][^\n]* {printf("\nIgnored Single-Line Comment:%s\n",yytext);line_cnt++;} 
[/][*][^\*]*[*][/] {printf("\nIgnored Multi-Line Comment:\n%s\n",yytext);} 

["][^"]*["] {printf("Literal String : %s\n",yytext);} 

"if"|"else" {printf("Keyword: %s\n",yytext);} 
"printf"|"scanf" {printf("Keyword: %s\n",yytext);} 
"int"|"main"|"return" {printf("Keyword: %s\n",yytext);} 

[0-9]+ {printf("Number: %s\n",yytext);} 
[0-9]+[.][0-9]* {printf("Floating Point Number: %s\n",yytext);} 
[a-zA-Z_][0-9a-zA-Z_]* {printf("Identifier: %s\n",yytext);} 

[<>=!][=] {printf("Relational Operator(Multi Char): %s\n",yytext);} 
[&][&] {printf("Logical Operator AND %s\n",yytext);} 
[|][|] {printf("Logical Operator OR %s\n",yytext);} 
[<>] {printf("Relational Operator(Single Char): %s\n",yytext);} 
[+\-*/=?] {printf("Operator: %s\n",yytext);}  
[ \t] {} //Ignored Whitespace 

[\(\)] {printf("Parenthesis: %s\n",yytext);} 
[\{\}] {printf("Curly Braces: %s\n",yytext);} 
[\[\]] {printf("Square Braces: %s\n",yytext);} 

[\,\;] {printf("Punctuation: %s\n",yytext);} 

[\n] {line_cnt++;}  

[0-9]+[a-zA-Z_]+ {printf("Invalid Token at Line : %d : %s\n", line_cnt,yytext);} 
[#@!][a-zA-Z_]+ {printf("Invalid Token at Line : %d : %s\n", line_cnt,yytext);} 
. {printf("Invalid Token at %d\n", line_cnt);} 
%% 

int yywrap(void){} 
int main(int argc, char **argv){ 
if (argc>1){ 
	FILE *file = fopen(argv[1], "r"); 
	if(!file){ 
		perror("fopen"); 
		return EXIT_FAILURE; 
	} 
	yyin=file; 
} 
yylex(); 
return 0; 
}
