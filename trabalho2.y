%{
    #include <stdio.h>
    void yyerror(char *c);
    int yylex(void);
    FILE *yyin;
%}

%token  START        END        PROG        IF        ELIF        COL        THEN        WHILE        DO        NOT
        FALSE        TRUE        INT        FLOAT        BOOL        VAR        READ        WRITE        OR        AND
        PLUS        MINUS        MULT        DIV        OPPAR        CLOPAR        EQ        LTHAN        GTHAN
        LEQTHAN        GEQTHAN        DIFF        ATRIB        DOUBDOT        SEMICON        NUM        ID
%%
programa: PROG id SEMICON bloco {printf("PROGRAMA ::= programa ID ; BLOCO\n");}
bloco: VAR declaracao START comandos END {printf("BLOCO ::= var DELCARACAO inicio COMANDOS fim\n")}
declaracao : 
    nome_var DOUBDOT tipo SEMICON { printf("DECLARACAO ::= nome_var : tipo ; \n"); };                            
    | nome_var DOUBDOT tipo SEMICON declaracao { printf("DECLARACAO ::= nome_var : tipo ; DECLARACAO \n"); };

nome_var : 
    id { printf("NOME_VAR ::= ID \n"); };
    | id COL nome_var { printf("NOME_VAR ::= ID , NOME_VAR \n"); };

tipo : 
    INT { printf("TIPO ::= inteiro \n"); };            
    | FLOAT { printf("TIPO ::= real \n"); }; 
    | BOOL { printf("TIPO ::= booleano \n"); }; 

comandos : 
    comando { printf("COMANDOS ::= COMANDO \n"); };
    | comando SEMICON comandos { printf("COMANDOS ::= COMANDO ; COMANDOS \n"); };

comando: 
    comando_combinado { printf("COMANDO ::= COMANDO_COMBINADO \n"); };
    | comando_aberto  { printf("COMANDO ::= COMANDO_ABERTO \n"); };

comando_combinado :
    IF expressao THEN comando_combinado ELIF comando_combinado { printf("COMANDO_COMBINADO ::= se EXPRESSAO entao COMANDO_COMBINADO senao COMANDO_COMBINADO \n"); };
    | atribuicao { printf("COMANDO_COMBINADO ::= ATRIBUICAO \n"); };
    | enquanto  { printf("COMANDO_COMBINADO ::= ENQUANTO \n"); };
    | leitura   {printf("COMANDO_COMBINADO ::= LEITURA \n"); };
    | escrita   { printf("COMANDO_COMBINADO ::= ESCRITA \n"); };

comando_aberto: 
    IF expressao THEN comando { printf("COMANDO_ABERTO ::= se EXPRESSAO entao COMANDO \n"); }
    | IF expressao THEN comando_combinado ELIF comando_aberto { printf("COMANDO_ABERTO ::= se EXPRESSAO entao COMANDO_COMBINADO senao COMANDO_ABERTO \n"); };

atribuicao : 
    id ATRIB expressao { printf("ATRIBUICAO ::= ID ::= EXPRESSAO \n"); };

enquanto : 
    WHILE expressao DO comando_combinado { printf("ENQUANTO ::= enquanto EXPRESSAO faca COMANDOS \n"); };

leitura : 
    READ OPPAR id CLOPAR { printf("LEITURA ::= leia ( ID ) \n"); };

escrita : 
    WRITE OPPAR id CLOPAR { printf("ESCRITA ::= escreva ( ID ) \n"); };

expressao : 
    simples { printf("EXPRESSAO ::= SIMPLES \n"); }
    | simples op_relacional simples { printf("EXPRESSAO ::= SIMPLES OP_RELACIONAL SIMPLES \n"); };

op_relacional : 
    DIFF { printf("OP_RELACIONAL ::= <> \n"); } | EQ { printf("OP_RELACIONAL ::= = \n"); } | LTHAN { printf("OP_RELACIONAL ::= < \n"); }
    | GTHAN { printf("OP_RELACIONAL ::= > \n"); } | LEQTHAN { printf("OP_RELACIONAL ::= <= \n"); }| GEQTHAN { printf("OP_RELACIONAL ::= => \n"); };

simples : 
    termo operador termo { printf("SIMPLES ::= TERMO OPERADOR TERMO \n"); }| termo { printf("SIMPLES ::= TERMO \n"); };

operador : 
    PLUS { printf("OPERADOR ::= + \n"); } | MINUS { printf("OPERADOR ::= - \n"); } | OR { printf("OPERADOR ::= ou \n"); };

termo : 
    fator { printf("TERMO ::= FATOR \n"); } | fator op fator{ printf("TERMO ::= FATOR OP FATOR \n"); };

op : 
    MULT { printf("OP ::= * \n"); } | DIV { printf("OP ::= div \n"); } | AND { printf("OP ::= e \n"); };

fator : 
    id { printf("FATOR ::= ID \n"); } | numero { printf("FATOR ::= NUMERO \n"); }| OPPAR expressao CLOPAR { printf("FATOR ::= ( EXPRESSAO ) \n"); }
    | TRUE { printf("FATOR ::= verdadeiro \n"); }| FALSE { printf("FATOR ::= falso \n"); }| NOT fator { printf("FATOR ::= nao FATOR \n"); };

id : 
    ID { printf("ID ::= id \n"); };

numero : 
    NUM { printf("NUMERO ::= numero \n"); };

%%
int main(int argc, char *argv[]) {
    char *arq = argv[1];
    FILE *arq = fopen(arq,"r");
    yyin = arq;
    fclose(arq);
    int var = yyparse();
    return var;
}
void yyerror(char *c) {
 printf("Erro: %s\n", c) ;
}