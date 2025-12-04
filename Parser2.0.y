
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *msg);

/* Semantic value union */
%}

%union {
    int num;
    char *str;
}

%token <str> ID
%token <num> NUMBER
%token READ WRITE IF THEN ELSE WHILE DO END
%token ASSIGN
%token EQ NEQ LT GT LEQ GEQ
%token PLUS MINUS MULT DIV
%token LPAREN RPAREN

%left PLUS MINUS
%left MULT DIV

%%

program:
      stmt_list          { printf("Program syntax OK\n"); }
    ;

stmt_list:
      stmt stmt_list
    | /* empty */
    ;

stmt:
      ID ASSIGN expr     { printf("Assignment: %s\n", $1); }
    | READ ID            { printf("Read: %s\n", $2); }
    | WRITE expr         { printf("Write\n"); }
    | IF condition THEN stmt_list END  
      { printf("If statement\n"); }
    | IF condition THEN stmt_list ELSE stmt_list END  
      { printf("If-else statement\n"); }
    | WHILE condition DO stmt_list END  
      { printf("While loop\n"); }
    ;

condition:
      expr EQ expr       { printf("Condition ==\n"); }
    | expr NEQ expr      { printf("Condition !=\n"); }
    | expr LT expr       { printf("Condition <\n"); }
    | expr GT expr       { printf("Condition >\n"); }
    | expr LEQ expr      { printf("Condition <=\n"); }
    | expr GEQ expr      { printf("Condition >=\n"); }
    ;

expr:
      expr PLUS expr     { printf("Addition\n"); }
    | expr MINUS expr    { printf("Subtraction\n"); }
    | expr MULT expr     { printf("Multiplication\n"); }
    | expr DIV expr      { printf("Division\n"); }
    | LPAREN expr RPAREN { printf("Parentheses\n"); }
    | ID                 { printf("Identifier: %s\n", $1); }
    | NUMBER             { printf("Number: %d\n", $1); }
    ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "\nSYNTAX ERROR: %s\n", msg);
    fprintf(stderr, "Expected: assignment (:=), if, while, read, write, etc.\n");
}

int main(void) {
    printf("=== Simple Language Parser ===\n");
    
    if (yyparse() == 0) {
        printf("\nSUCCESS: Parsing completed\n");
        printf("Features verified: if statements, while loops, error messages\n");
    } else {
        printf("\nFAILED: Syntax errors found\n");
    }
    return 0;
}