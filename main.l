
%{
    FILE *inputFile;
    // declatarions
%}

%s IN_FUNCTION DATA_TYPE NAME

word [a-zA-Z]+
digit [0-9]+
dataType "int"|"char"|"void"
name [a-zA-Z0-9]*
vectorDec "["{digit}*"]"
varDec {dataType}" "+{name}{vectorDec}*
args {varDec}","" "*
params {args}*{varDec}

function {dataType}" "+{name}" "*"("{params}*")"

%%

<INITIAL>{function} {
    printf("%s\n", yytext);

    char *copyStr = (char *)calloc(strlen(yytext) + 1, sizeof(char));

    strcpy(copyStr, yytext);

    int i;
    for (i = strlen(copyStr); i >= 0; i--) {
        unput(copyStr[i]);
    }

    BEGIN(DATA_TYPE);
}

<DATA_TYPE>{dataType} {
    printf("\ttip intors: %s\n", yytext);
    BEGIN(NAME);
}

<NAME>{name} {
    printf("\tnume: %s\n", yytext);
    
    BEGIN(INITIAL);
}

<NAME>"(" {
    printf("ok");
    BEGIN(INITIAL);
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
