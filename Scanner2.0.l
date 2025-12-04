%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "Parser2.0.tab.h"
%}

%%

"read"      return READ;
"write"     return WRITE;
"if"        return IF;
"then"      return THEN;
"else"      return ELSE;
"end"       return END;
"while"     return WHILE;
"do"        return DO;

":="        return ASSIGN;
"=="        return EQ;
"!="        return NEQ;
"<="        return LEQ;
">="        return GEQ;
"<"         return LT;
">"         return GT;

"+"         return PLUS;
"-"         return MINUS;
"*"         return MULT;
"/"         return DIV;

"("         return LPAREN;
")"         return RPAREN;

[a-zA-Z][a-zA-Z0-9]*    { yylval.str = strdup(yytext); return ID; }
[0-9]+                  { yylval.num = atoi(yytext); return NUMBER; }
[ \t\n]                 ;
.                       { fprintf(stderr, "Error: bad character '%c'\n", yytext[0]); exit(1); }

%%

int yywrap() {
    return 1;
}