%{
#include "calculator.tab.h"
%}


%%
[0-9]+ { yylval = atoi(yytext); return ID; }
[+\-\*\/] { return yytext[0]; }
[ \t]+ {}
\n { return '\n'; }
. { return yytext[0]; }
%%

int yywrap() { return 1; }

