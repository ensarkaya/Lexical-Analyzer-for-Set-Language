%option noyywrap
%{
#include<stdio.h>
int lines=1;
%}
pre_decleration  (\<)
read  (read)
write  (write)
variable_type  (set)
ret  (return)
beg  (begin)
bre  (break)
boolean  (true|false|TRUE|FALSE)
comment  (\#)
comment_b_s  (\/\*)
comment_b_e  (\*\/)
func_call  (func)
sign [+-]
letter 		[A-Za-z]
digit 		[0-9]
alphanumeric 	({letter}|{digit})
char	 	[^alphanumeric|comment|pre_decleration|sign|\ ]
all  (.)

%%
{beg} 			  		 printf(" BEGIN");
\end 			 	         printf(" END");
\n 			 	        {printf(" L%d %s \n",lines,yytext);lines++;};
\[ 			 	     	 printf(" SUB_SET");
\!\[ 			 		 printf(" NOT_SUB_SET");
\] 			 	  	 printf(" SUP_SET");
\!\]	 		 		 printf(" NOT_SUP_SET");
\"                                       printf(" QUOTE");
\=	 	 	 	 	 printf(" ASSIGN_OP");
\&			 	 	 printf(" AND");
{boolean}	 	 	  	 printf(" %s", yytext);
{ret}	  		 		 printf(" RETURN");
{bre}	  		 		 printf(" BREAK");
\continue		 	         printf(" CONTINUE");
\,			 	 	 printf(" COMMA");
\const			 	 	 printf(" CONSTANT");
\'			 	 	 printf(" COMPLEMENT");
\*			 	 	 printf(" CARTESIAN_PRODUCT");
\else	 		  		 printf(" ELSE");
\=\=			 	 	 printf(" EQUALS");
\!\=			 		 printf(" NOT_EQUALS");
\Set[ \t]+{func_call}[ \t]+{alphanumeric}+      printf(" FUNCTION_DECLERATION");
{func_call}[ \t]+{alphanumeric}+   	 printf(" FUNCTION_CALL");
\^			 		 printf(" INTERSECTION");
\if			  	         printf(" IF");
\(			  		 printf(" LB");
\{			    		 printf(" LCB");
\!			  		 printf(" NOT");
\while			  	  	 printf(" WHILE");
\|			     		 printf(" OR");
\)			      		 printf(" RB");
\}			 	 	 printf(" RCB");
{read}			  		 printf(" SCANNER");
\-			    		 printf(" SUBSTRACTION");
\;			 		 printf(" SEMICOLON");
\+			  		 printf(" UNION");
{sign}?{digit}*		    	  	 printf(" INTEGER");
\Set[ \t]+{pre_decleration}{alphanumeric}+      printf(" VARIABLE_DECLERATION ");
{pre_decleration}{alphanumeric}+         printf(" VARIABLE ");
{write}				 	 printf(" PRINT");
{letter}({alphanumeric}|_)*	   	 printf(" IDENTIFIER");
{char}			 		 printf(" CHAR");
{all}   ;/*do nothing*/ 
{comment_b_s}({all})*{comment_b_e} 	 printf(" B_COMMENT");
{comment}{all}*	 		  	 printf(" COMMENT");
%%
int main()
{
  yylex();
  return 0;
}