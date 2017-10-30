%{
	#include <iostream>
	#include <istream>
	#include <ostream>		
	#include <FlexLexer.h>	

	int lineNo = 1;
	int colNo = 1;

%}
%option c++
%option noyywrap

%x multilinecomment

		
Single_line_comment		(\/\/)+[^\n]*
Integer					[1-9][0-9]*|0
Identifier              [a-zA-Z_][a-zA-Z0-9_]*

%%
"if"			{
							colNo += strlen(yytext);
						}
"as"
						{
							colNo+=strlen(yytext);
						}
"case"                  {
							colNo+=strlen(yytext);
						}
						
"const"					{
							colNo+=strlen(yytext);
						}
"do"					{
							colNo+=strlen(yytext);
						}
"explicit"				{	
							colNo+=strlen(yytext);
						}
"float"					{
							colNo+=strlen(yytext);
						}
"internal"				{
							colNo+=strlen(yytext);
						}
"new"					{
							colNo+=strlen(yytext);
						}
"override"				{
							colNo+=strlen(yytext);
						}
"readonly"				{
							colNo+=strlen(yytext);
						}
"short"					{	
							colNo+=strlen(yytext);
						}
"string"				{	
							colNo+=strlen(yytext);
						}
"true"					{
							colNo+=strlen(yytext);
						}
"unchecked"				{
							colNo+=strlen(yytext);
						}
"virtual"				{
							colNo+=strlen(yytext);
						}
\/\*                                        { BEGIN multilinecomment; }
<multilinecomment>[^*\n]*					{;}
<multilinecomment>"*"+[^*/\n]*				{lineNo++;}
<multilinecomment>"*"+"/"                   { BEGIN INITIAL;cout<<"\t it is a Multi Line Comment \n";}

{Single_line_comment}				{ cout<<"\tit is a single line comment\n";
										lineNo++;
									}

{Identifier}						{ colNo += strlen(yytext);
										cout<<yytext<<endl;;
										cout<<"\t it is id \n";
									}

{Integer}							{
										colNo += strlen(yytext);
										int x=atoi(yytext);
										cout<<x<<endl;
										
									}
											

%%

int main(void)
{
	FlexLexer* lexer = new yyFlexLexer;
	lexer->yylex();
    return 0;
}