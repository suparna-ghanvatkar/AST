%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#define YYSTYPE int
	void threeaddresscode();
	char addtotable(char,char,char);
	int ind=0;
	char temp='A';
	struct incod
	{
		char opd1,opd2,opr;
	};
%}

%token LETTER NUMBER
//%type expr
%left '+''-'
%right '/''*'

%%
statement:LETTER '=' expr ';'{$$=addtotable((char)$1,(char)$3,'=');}
	|expr ';' ;
expr:	expr '+' expr {$$=addtotable((char)$1,(char)$3,'+');}
	|expr '-' expr {$$=addtotable((char)$1,(char)$3,'-');}
	|expr '*' expr {$$=addtotable((char)$1,(char)$3,'*');}
	|expr '/'expr {$$=addtotable((char)$1,(char)$3,'/');}
	|'('expr')'{$$=(char)$2;}
	|LETTER {$$=(char)$1;}
	|NUMBER {$$=(char)$1;}
;
%%

yyerror(char *s)
{
	printf("%s",s);
	exit(0);
}
struct incod code[20];
int id=0;

char addtotable(char opd1,char opd2,char opr)
{
	code[ind].opd1=opd1;
	code[ind].opd2=opd2;
	code[ind].opr=opr;
	//printf("%d:%c,%c,%c,%c\n",ind,temp,opd1,opd2,opr);
	ind++;
	temp++;
	return temp-1;
}

void threeaddresscode()
{
	int cnt=0;
	temp='A';
	printf("three address code\n");
	while(cnt<ind)
	{
		printf("%c=\t",temp);
		if(isalpha(code[cnt].opd1))
			printf("%c \t",code[cnt].opd1);
		else
			printf("%c \t",temp);

		printf("%c \t",code[cnt].opr);

		if(isalpha(code[cnt].opd2))
			printf("%c \t",code[cnt].opd2);
		else
			printf("%c \t",temp);

		printf("\n");
		cnt++;
		temp++;
	}
}

main()
{
	printf("enter the expression");
	yyparse();
	//temp='A';
	threeaddresscode();
}

yywrap()
{
		return 1;
}
