%{
	#include<stdio.h>
	#include <string.h>
	#include "program.tab.h"
	#include<stdlib.h>
%}

identifiers "var_"[a-zA-Z0-9]+
unary_operator "inc"|"dec"|"not"
library_func "IN<"|"OUT>"
integer [+-]?[0-9]+
float [+-]?[0-9]+[.][0-9]+|[+-]?[.][0-9]+|[1-9]+e[+-][0-9]+
double [+-]?[0-9]+[.][0-9]+{6,12}|[+-]?[.][0-9]+|[1-9]+e[+-][0-9]+{6,12}
char [A-Za-z]+
single_line_comment [#][#].*
multiple_line_comment [ ]*[#][/][a-zA-Z0-9!@#*(){}_+-,.:\|?><\n\t ]*[/][#]

/*RE and Action*/

%%


{single_line_comment} {
	printf("single line comment\n");

}
{multiple_line_comment} {
	printf("multiline comment");
}

{unary_operator}   {return inc;}
"["	 { return LB; }
"]"	  { return RB; }
"break_loop"    {   return BREAK;     }
"choose"      { return CASE;      }
"switch"      { return SWITCH;	}
"default"     {  return DEFAULT; 	}
"loop_while" { return WHILE;}
"intData"	{ return INT; }
"floatData"	{ return FLOAT; }
"doubleData"	{return DOUBLE;}
"charType"	{ return CHAR; }
":"     { return COL;}
{integer}	{ 
		yylval.number = atoi(yytext);
		return NUM;
	}
"loop_for"   { return FOR;}	
"<"	{ return LP; }
">"	{ return RP; }
"|"	{ return CM; }
"//"	{ return SM; }
"add"	{ return PLUS;}
"sub"	{ return MINUS; }
"mul"	{ return MULT; }
"div"	{ return DIV; }
"pow"	{ return POW; }
"fact"	{ return FACT; }
":="		{ return ASSIGN;  }
"bigger"	{ return GT; }
"smaller"	{ return LT; }
"smalleq" {return LOE;}
"bigeq" {return GOT;}

{identifiers} {
	 yylval.string=strdup(yytext);
	 return VAR;
	}

"cond"		{ return IF;}
"anti_cond"		{ return ELSE;}
"xtra_cond"	{ return ELIF; }

"function "[A-Za-z]+	{ return FUNCTION; }

[ \t\n]*	

.	{
		yyerror("Unknown Character.\n");
	}
%%

int main()
{
	yyin = freopen("in.txt","r",stdin);
	yyout = freopen("out.txt","w",stdout);
	yyparse();	
}