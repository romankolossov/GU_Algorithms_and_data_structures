//
//  main.c
//  KolosovR|Algoritms|hw2
//
//  Created by Roman Kolosov on 30.07.2021.
//

#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#define ArrSize 64
// Home work of the lesson 2 by Roman Kolosov

int menu(void);
void task1(void);
void task2(void);

void convertDecimalToBinary(int decimalNumber);
void binaryNumberPrint(void);

long power(int base, int degree);
int recursionPower(int base, int degree);
int quickRecursionPower(int base, int degree);

// Set the value of the first element to set to the zero the rest ones.
int binaryNumber[ArrSize] = {0};
int size = 0; // Actual size of the array.
int i = 0; // Counter.

// MARK: - Main function

int main(int argc, const char * argv[]) {
    int task;

    do {
        task = menu();

        switch (task) {
            case 1:
                task1();
                break;
            case 2:
                task2();
                break;
            case 0:
                printf("Thank You for using the app,\nBye-bye.\n\n");
                break;
                
            default:
                break;
        }
    } while (task != 0);

    return 0;
}

// MARK: - Menu function

int menu() {
    int task = -1;

    printf("\n\n1 - Task 1. Convrtation from decimal to binary number system using recursion.\n");
    printf("2 - Task 2. Raising the number a to the power of b\n");
    printf("0 - Exit\n");

    do {
        scanf("%i", &task);
        getchar();
        if (task < 0 || task > 4) {
            printf("Please, enter the number between 1 and 4 or 0 for exit\n");
        }
    } while (task < 0 || task > 4);

    return  task;
}

// MARK: - Task functions

void task1() {
    printf("Task 1. Convrtation from decimal to binary number system using recursion");
    printf("\nThis programm will convert the number from decimal to binary number system using recursion");

    int decimalNumber;

    printf("\nPlease, enter the number to convert: ");
    scanf("%d", &decimalNumber);

    // Prepare to convert.
    memset(binaryNumber, 0, sizeof binaryNumber); // Reset the array.
    size = 0; // Reset the actual size of the array.
    i = 0; // Reset the counter.

    convertDecimalToBinary(decimalNumber);

    printf("The bitary number of %d\nis ", decimalNumber);
    binaryNumberPrint();
}

void task2() {
    printf("Task 2. Raising the number a to the power of b");
    printf("\nThis programm will calculate the power of a in degree of b");

    int base, degree;
    long result, recursionResult, quickRecursionResult;

    printf("\nPlese, enter the power base a: ");
    scanf("%d", &base);
    printf("Plese, enter the power b: ");
    scanf("%d", &degree);

    result = power(base, degree);
    recursionResult = recursionPower(base, degree);
    quickRecursionResult = quickRecursionPower(base, degree);

    printf("The power of a = %d in degree of b = %d,\nis equal %ld", base, degree, result);
    printf("\nThe power with recursion use of a = %d in degree of b = %d,\nis equal %ld", base, degree, recursionResult);
    printf("\nThe power with qick recursion use of a = %d in degree of b = %d,\nis equal %ld", base, degree, quickRecursionResult);
}

// MARK: - Calculation functions

void convertDecimalToBinary(int decimalNumber) {
    if (decimalNumber > 0)
    {
        if (decimalNumber % 2 == 1) {
            binaryNumber[i] = 1;
        } else {
            binaryNumber[i] = 0;
        }
        i++;
        size = i;

        convertDecimalToBinary(decimalNumber / 2);
    }
}

void binaryNumberPrint() {
    for ( int i = size - 1; i >= 0; i--) {
        printf("%d", binaryNumber[i]);
    }
}

long power(int base, int degree) {
    long result = 1;
    while (degree) {
        result = result * base;
        degree--;
    }
    return result;
}

int recursionPower(int base, int degree) {
    if(degree > 0)
        return base * recursionPower(base, degree - 1);
    else
        return 1;
}

int quickRecursionPower(int base, int degree) {
    if(degree > 0)
        if (degree % 2) {
            return base * quickRecursionPower(base, degree - 1);
        } else {
            base = base * base;
            degree = degree / 2;
            return quickRecursionPower(base, degree);
        }
    else
        return 1;
}

