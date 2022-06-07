%option noyywrap
%{
   #include <stdio.h>
   int linhas=1;
%}

/*regras de traducao*/
numero [0-9]+ 
id [a-zA-Z]+
numreal "-"?[0-9]*[.][0.9]*


%%
\n {linhas++; printf("\n");}
\t {}


"inicio" {printf("<BEGGIN, %d>",linhas);}
"fim" {printf("<END, %d>",linhas);}
"programa" {printf("<PROG, %d>",linhas);}
"se" {printf("<IF, %d>",linhas);}
"senao" {printf("<ELIF, %d>", linhas);}
"entao" {printf("<ELSE, %d>",linhas);}
"enquanto" {printf("<WHILE, %d>",linhas);}
"faca" {printf("<DO, %d>",linhas);}
"nao" {printf("<NOT, %d>",linhas);}
"falso" {printf("<FALSE, %d>",linhas);}
"verdadeiro" {printf("<TRUE, %d>",linhas);}
"inteiro" {printf("<INT, %d>",linhas);}
"real" {printf("<FLOAT, %d>",linhas);}
"booleano" {printf("<BOOL, %d>",linhas);}
"var" {printf("<VAR, %d>",linhas);}
"leia" {printf("<READ, %d>",linhas);}
"escreva" {printf("<WRITE, %d>",linhas);}
"ou" {printf("<OR, %d>",linhas);}
"e" {printf("<AND, %d>",linhas);}
"+" {printf("<PLUS, %d>",linhas);}
"-" {printf("<MINUS, %d>",linhas);}
"*" {printf("<MULT, %d>",linhas);}
"div" {printf("<DIV, %d>",linhas);}
"(" {printf("<OPPAR, %d>",linhas);}
")" {printf("<CLOPAR, %d>",linhas);}
"=" {printf("<EQ, %d>",linhas);}
"<" {printf("<LTHAN, %d>",linhas);}
">" {printf("<GTHAN, %d>",linhas);}
"<=" {printf("<LEQTHAN, %d>",linhas);}
">=" {printf("<GEQTHAN, %d>",linhas);}
"<>" {printf("<DIFF, %d>",linhas);}
":=" {printf("<ATRIB, %d>",linhas);}
":" {printf("<DOUBDOT, %d>",linhas);}
";" {printf("<SEMICON, %d>",linhas);}
"," {printf("<COL, %d>",linhas);}
{numero} {printf("<NUM, %d>",linhas);}
{id} {printf("<ID, %d>",linhas);}
{numreal} {printf("<NUMREAL, %d>",linhas);}

%%
int main(int argc, char *argv[]){ 
   FILE *arq = fopen(argv[1],"r");
   yyin =arq;
   yylex();
   fclose(arq);
   return 0;
}