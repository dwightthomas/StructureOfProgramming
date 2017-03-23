/*Written byy Dwight Thomas*/
/*Note I added a token and lexeme to the program called New Line with token 30 to help handle new lines
and thus deal with mupltiple lines of instructions*/
/*The gramma is
<expr> → <term> {(+ | -) <term>}
<term> → <factor> {(* | /) <factor>}
<factor> → id | int_constant | ( <expr> )
*/

#include <stdio.h>
#include <stdlib.h>

/* Global declarations */
/* Variables */
int charClass;
char lexeme [100];
char nextChar;
int lexLen;
int token;
int nextToken;
FILE *in_fp, *fopen();
/* Function declarations */
void addChar();
void getChar();
void getNonBlank();
int lex();

/* Character classes */
#define LETTER 0
#define DIGIT 1
#define UNKNOWN 99
/* Token codes */
#define INT_LIT 10
#define IDENT 11
#define ASSIGN_OP 20
#define ADD_OP 21
#define SUB_OP 22
#define MULT_OP 23
#define DIV_OP 24
#define LEFT_PAREN 25
#define RIGHT_PAREN 26
#define NEW_LINE 30


/******************************************************/
/* main driver */
main()
{
    /* Open the input data file and process its contents */
    if ((in_fp = fopen("C:\\Users\\DwightThomas\\Desktop\\My Stuff\\SKL\\This Semester\\Structures of Prog\\Assignments\\StructureOfProgramming\\Assignment 3\\Assignment3\\text.txt", "r")) == NULL)
        printf("ERROR - cannot open text.txt \n");
    else
    {
        getChar();
        /*FIGURE OUT HOW TO HANDLE THE NEXT LINE CHARACTER FOR FREE FLOW TO NEW LINE OF INSTRUCTIONS*/
        do {
                lex();
                expr();
                /*This block is for when we get to a new line it gives a space for better presentation*/
                if(nextToken == NEW_LINE && nextChar != EOF)
                    printf("\nNext Line of input\n\n");
        } while (nextToken != EOF);
    }
}

/*****************************************************/
/* lookup - a function to lookup operators and parentheses
 and return the token */
int lookup(char ch)
{
    switch (ch)
    {
        case '(':
               addChar();
               nextToken = LEFT_PAREN;
               break;
        case ')':
            addChar();
            nextToken = RIGHT_PAREN;
            break;
        case '+':
            addChar();
            nextToken = ADD_OP;
            break;
        case '-':
            addChar();
            nextToken = SUB_OP;
            break;
        case '*':
            addChar();
            nextToken = MULT_OP;
            break;
        case '/':
            addChar();
            nextToken = DIV_OP;
            break;
        /*This handles the next line character so multple lines of instructions can be handled*/
        case '\n':
            nextToken = NEW_LINE;
            break;
        default:
            addChar();
            nextToken = EOF;
            break;
    }
    return nextToken;
}

/*****************************************************/
/* addChar - a function to add nextChar to lexeme */
void addChar()
{
    if (lexLen <= 98)
    {
        lexeme[lexLen++] = nextChar;
        lexeme[lexLen] = 0;
    }
    else
        printf("Error - lexeme is too long \n");
}


/*****************************************************/
/* getChar - a function to get the next character of
 input and determine its character class */
void getChar()
{
    if ((nextChar = getc(in_fp)) != EOF)
    {
        if (isalpha(nextChar))
            charClass = LETTER;
        else if (isdigit(nextChar))
            charClass = DIGIT;
            else
                charClass = UNKNOWN;
    }
    else
        charClass = EOF;
}


/*****************************************************/
/* getNonBlank - a function to call getChar until it
 returns a non-whitespace character */
void getNonBlank()
{
    /*This if is put so that the new line character is no longer just dissmissed as black space*/
    if(nextChar != '\n')
    {
        while (isspace(nextChar))
            getChar();
    }
}


/*****************************************************/
/* lex - a simple lexical analyzer for arithmetic
 expressions */
int lex()
{
    lexLen = 0;
    getNonBlank();
    switch (charClass)
    {
        /* Parse identifiers */
        case LETTER:
            addChar();
            getChar();
            while (charClass == LETTER || charClass == DIGIT)
            {
                addChar();
                getChar();
            }
            nextToken = IDENT;
            break;
        /* Parse integer literals */
        case DIGIT:
            addChar();
            getChar();
            while (charClass == DIGIT)
            {
                addChar();
                getChar();
            }
            nextToken = INT_LIT;
            break;
        /* Parentheses and operators */
        case UNKNOWN:
            lookup(nextChar);
            getChar();
            /*This if statement handles the new line to give a lexeme that will be shown stating that we're going to a next line*/
            if(nextToken == NEW_LINE)
            {
                /*This if is here so that when we get to the end of file we dont say new line and then EOF but just EOF*/
                if(nextChar != EOF)
                {
                    lexeme[0] = 'N';
                    lexeme[1] = 'E';
                    lexeme[2] = 'W';
                    lexeme[3] = ' ';
                    lexeme[4] = 'L';
                    lexeme[5] = 'I';
                    lexeme[6] = 'N';
                    lexeme[7] = 'E';
                    lexeme[8] = 0;
                }
                else
                {
                    nextToken = EOF;
                    lexeme[0] = 'E';
                    lexeme[1] = 'O';
                    lexeme[2] = 'F';
                    lexeme[3] = 0;
                }
            }

            break;
        /* EOF */
        case EOF:
            nextToken = EOF;
            lexeme[0] = 'E';
            lexeme[1] = 'O';
            lexeme[2] = 'F';
            lexeme[3] = 0;
            break;
    } /* End of switch */
    printf("Next token is: %d, Next lexeme is %s\n",
    nextToken, lexeme);
    return nextToken;
} /* End of function lex */


/* expr
 Parses strings in the language generated by the rule:
 <expr> -> <term> {(+ | -) <term>}
 */
void expr()
{
    printf("Enter <expr>\n");
    /* Parse the first term */
    term();
    /* As long as the next token is + or -, get
    the next token and parse the next term */
    while (nextToken == ADD_OP || nextToken == SUB_OP)
    {
        lex();
        term();
    }
    printf("Exit <expr>\n");
} /* End of function expr */

/* term
 Parses strings in the language generated by the rule:
 <term> -> <factor> {(* | /) <factor>)
 */
void term()
{
    printf("Enter <term>\n");
    /* Parse the first factor */
    factor();
    /* As long as the next token is * or /, get the
    next token and parse the next factor */
    while (nextToken == MULT_OP || nextToken == DIV_OP)
    {
        lex();
        factor();
    }
    printf("Exit <term>\n");
} /* End of function term */


/* factor
 Parses strings in the language generated by the rule:
 <factor> -> id | int_constant | ( <expr )
 */
void factor()
{
    printf("Enter <factor>\n");
    /* Determine which RHS */
    if (nextToken == IDENT || nextToken == INT_LIT)
        /* Get the next token */
        lex();
        /* If the RHS is ( <expr>), call lex to pass over the
        left parenthesis, call expr, and check for the right
        parenthesis */
    else
    {
        if (nextToken == LEFT_PAREN)
        {
            lex();
            expr();
            if (nextToken == RIGHT_PAREN)
                lex();
            else
                error();
        } /* End of if (nextToken == ... */
        /* It was not an id, an integer literal, or a left
        parenthesis */
        else
            error();
    } /* End of else */
    printf("Exit <factor>\n");;
} /* End of function factor */


/*error
This function is here to handle any syntax errors that may occur with instructions that can't be handled with this grammar
*/
void error()
{
    printf("\nA syntax error as occured here with %s \n\n", lexeme);
}
