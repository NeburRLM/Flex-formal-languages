%{
#include <stdio.h>
#include <stdlib.h>
int bin_count = 0; // contador per als nombres en binari
int oct_count = 0; // contador per als nombres en octal
int hex_count = 0; // contador per als nombres en hexadecimal
%}

%option noyywrap

%%

0[bB][01]+    { printf("Número en base 2: %s\n", yytext); bin_count++; }
0[oO][0-7]+   { printf("Número en base 8: %s\n", yytext); oct_count++; }
0[xX][0-9a-fA-F]+(\.[0-9a-fA-F]+)?   { printf("Número en base 16: %s\n", yytext); hex_count++; }

%%

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Sintaxi: %s <fitxer>\n", argv[0]);
        return 1;
    }
    FILE *fitxer = fopen(argv[1], "r");
    if (!fitxer) {
        printf("No s'ha pogut obrir el fitxer %s\n", argv[1]);
        return 1;
    }
    yyin = fitxer;
    yylex();
    fclose(fitxer);
    printf("Nombre d'aparicions de nombres en base 2: %d\n", bin_count);
    printf("Nombre d'aparicions de nombres en base 8: %d\n", oct_count);
    printf("Nombre d'aparicions de nombres en base 16: %d\n", hex_count);
    return 0;
}


