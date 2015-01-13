
%{
    FILE *inputFile;
    // declatarions
%}

%s IN_FUNCTION FUNCTION_HEADER FUNCTION_NAME RETURN_TYPE

word [a-zA-Z]+
digit [0-9]+
dataType "int"|"char"|"void"
name [a-zA-Z0-9]+
vectorDec "["{digit}*"]"
varDec {dataType}" "+{name}{vectorDec}*
args {varDec}","" "*
params {args}*{varDec}

function {dataType}" "+{name}" "*"("{params}*")"

%%

<INITIAL>{function} {
                        printf("%s\n", yytext);

                        BEGIN(FUNCTION_HEADER); 
                        yy_scan_string(yytext);
                        yylex();

                        stdin = inputFile;
                    }

<FUNCTION_HEADER>{dataType}" "+{name} {
            BEGIN(RETURN_TYPE);
            
            yy_scan_string(yytext);
            yylex();
        }

 
<RETURN_TYPE>{dataType} {
            printf("\ttipul intors: %s\n", yytext); 
            
            BEGIN(FUNCTION_NAME);
        }

<FUNCTION_NAME>{name} {
            printf("\tnume: %s\n", yytext);

            BEGIN(IN_FUNCTION);
        }


. {}
\n {}

%%


int main (int argc, char **argv) {
    inputFile = fopen(argv[1], "r");

    if (inputFile == NULL) {
        printf("Nu s-a putut deschide fisierul\n");
        return -1;
    }

    yyin = inputFile;
    yylex();

    return 0;
}
