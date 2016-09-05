%{
#include "y.tab.h"
extern char yylval;
%}

NUMBER [0-9]+
LETTER [a-zA-Z]+

%%
{NUMBER} {yylval=(char)yytext[0];return NUMBER;}
{LETTER} {yylval=(char)yytext[0];return LETTER;}
\n {return 0;}
. {return yytext[0];}
%%
