%{
	#include <stdlib.h>
	#include <string.h>
	#include "symbols.h"
	int errores = 0;

	addSymbol(char *symName, char *type){
		symTable *sym;
		// Iniciando busqueda de simbolo
		sym = getSymbol(symName);

		if (sym == 0){	//El símbolo no existe.
			sym = putSymbol(symName, type);
		} else{		//El símbolo existe
			errores++;
			printf("El simbolo %s ya existe\n", symName);
		}
	}
	printErrors(){		printf("Errores encontrados: %i\n", errores);	}

%}
 
/*TIPOS*/
%union{
	int 	intval;
	float 	fval;
	char	*name;
};
/*TIPOS*/
/*TOKENS*/
	%token <name>	ID
	%token <intval>	ENTERO
	%token <fval>	FLOTANTE
	%token PR_BEGIN
	%token <name>	PR_END
	%token <name>	PR_INT
	%token <name>	PR_FLOAT
	%token PR_IF
	%token THEN
	%token WHILE
	%token PR_DO
	%token REPEAT
	%token UNTIL
	%token PRINT
	%token READ
	%token OPEN_BRACKET
	%token CLOSE_BRACKET
	%token ADD
	%token SUB
	%token MULT
	%token DIV
	%token MENQ
	%token MAYQ
	%token IGUAL
	%token ASSIGN
	%token PCOM
	%type <name> tipo
/*TOKENS*/

/*ORDEN DE OPERADORES*/
	%left ADD SUB
	%left MULT DIV
/*ORDEN DE OPERADORES*/
%start prg
 
%%
prg		:	opt_decls PR_BEGIN opt_stmts PR_END
		;

opt_decls	:	decls
			|
			;

decls 	:	decls PCOM dec
		|	dec
		;

dec 	: tipo ID 	{addSymbol($2, $1); }
		;

tipo	:	PR_INT		{ $$="int"; }
		|	PR_FLOAT	{ $$="float"; }
		;

stmt 	:	ID ASSIGN expr
		|	PR_IF expresion THEN stmt
		|	WHILE expresion PR_DO stmt
		|	REPEAT stmt UNTIL expresion
		|	PR_BEGIN opt_stmts PR_END
		|	PRINT expr
		|	READ ID
		;

opt_stmts 	:	stmt_lst
			;

stmt_lst 	:	stmt_lst PCOM stmt
			|	stmt
			;

expresion 	:	expr MENQ expr
			|	expr MAYQ expr
			|	expr IGUAL expr
			;

expr 	:	expr ADD term
		|	expr SUB term
		|	term
		;

term 	:	term MULT factor
		|	term DIV factor
		|	factor
		;

factor	:	OPEN_BRACKET expr CLOSE_BRACKET
		|	ID
		|	ENTERO
		|	FLOTANTE
		;
