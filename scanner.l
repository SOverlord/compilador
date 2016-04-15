%{
   #include <stdio.h>
   #include "y.tab.h"
   extern YYSTYPE yylval;
%}
%option noyywrap
%option yylineno
id 			[a-zA-Z]([0-9][a-zA-Z])*
nument		[0-9][0-9]*
numf		{nument}.{nument}
ignora 		" "|\t|\n
operadores	*|+|-|/

%%
{ignora}+	{														;}
{id}		{yylval.name = (char *) strdup(yytext);	return ID;		}
{nument}	{yylval.fval = atoi( yytext );			return ENTERO; 	}
{numf}		{yylval.intval = atoi( yytext );		return FLOTANTE;}
"end"		{return PR_END			;}
"begin"		{return PR_BEGIN		;}
"int"		{return PR_INT			;}
"float"		{return PR_FLOAT		;}
"if"        {return PR_IF			;}
"then"		{return THEN 			;}
"while"		{return WHILE 			;}
"do"		{return PR_DO			;}
"repeat"	{return REPEAT 			;}
"until"		{return UNTIL 			;}
"print"		{return PRINT 			;}
"read"		{return READ 			;}
"("			{return OPEN_BRACKET 	;}
")"			{return CLOSE_BRACKET 	;}
"+"			{return ADD 			;}
"-"			{return SUB 			;}
"*"			{return MULT 			;}
"/"			{return DIV 			;}
"<"			{return MENQ 			;}
">"			{return MAYQ 			;}
"="			{return IGUAL 			;}
":="		{return ASSIGN 			;}
";"			{return PCOM 			;}
. 			{return(yytext[0]) 		;}
%%

int main(int argc,char *argv[]) {
	if ((yyin = fopen(argv[1], "rt")) == NULL) {
		printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
	}
	else {
		//yylex();
		//printf("Archivo abierto\n");
		yyparse();
		//printf("Errores: %i", errores);
		printErrors();
	}
	fclose(yyin);
	return 0;
}