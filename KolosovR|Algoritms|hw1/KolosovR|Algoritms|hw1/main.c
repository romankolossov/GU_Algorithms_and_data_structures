//
//  main.c
//  KolosovR|Algoritms|hw1
//
//  Created by Roman Kolosov on 25.07.2021.
//

#include <stdio.h>
#include <math.h>
// Home work of the lesson 1 by Roman Kolosov

void task1(void);
void task2(void);
void task3(void);
void task4(void);
void swapValuesOfVariablesByAddress(int *x, int *y);

int calculateQuadraticEquation(float a, float b, float c, float* x1, float* x2);
int menu(void);
float maxOfPair(float a, float b);

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
            case 3:
                task3();
                break;
            case 4:
                task4();
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

    printf("\n\n1 - Task 1. Body mass index calculation\n");
    printf("2 - Task 2. Define the max number from four ones\n");
    printf("3 - Task 3. Swap values of two variables\n");
    printf("4 - Task 4. Find solutions of quadratic equations\n");
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
    printf("Task 1. Body mass index calculation");

    double height, weight, massIndex;

    printf("\nThis programm will calculate a body mass index I = weight/(height*height)");
    printf("\nEnter height: ");
    scanf("%lf", &height);
    printf("Enter weight: ");
    scanf("%lf", &weight);

    massIndex = weight / pow(height, 2);

    printf("The body mass index with\nheight = %.2lf and weight = %.2lf\nis %lf", height, weight, massIndex);
}

void task2() {
    printf("Task 2. Definding the max number of four ones");

    float a, b, c, d, firstPairMax, secondPairMax, max;

    printf("\nThis programm will find the maximum of four numbers a,b,c and d");
    printf("\nEnter a: ");
    scanf("%f", &a);
    printf("Enter b: ");
    scanf("%f", &b);
    printf("Enter c: ");
    scanf("%f", &c);
    printf("Enter d: ");
    scanf("%f", &d);

    firstPairMax = maxOfPair(a, b);
    secondPairMax = maxOfPair(c, d);
    max = maxOfPair(firstPairMax, secondPairMax);

    printf("The maximum of\na = %f, b = %f,\nc = %f, d = %f \nis %f", a, b, c, d, max);
}

void task3() {
    printf("Task 3. Swap values of two variables");
    printf("\nThis programm will swap values of firts and second variadles");

    printf("\nSwap by address:");
    int first = 50;
    int second = 70;
    printf("\nfirst = %d, second = %d", first, second);
    swapValuesOfVariablesByAddress(&first, &second);
    printf("\nfirst = %d, second = %d", first, second);

    printf("\nSwap using third variable:");
    int buffer;
    first = 50;
    second = 70;
    printf("\nfirst = %d, second = %d", first, second);
    buffer = first;
    first = second;
    second = buffer;
    printf("\nfirst = %d, second = %d", first, second);
}

void task4() {
    printf("Task 4. Finding solutions of quadratic equations");

    float a, b, c, x1, x2;

    printf("\nThis programm will calculate a square equation 'ax2 + bx + c = 0'");
    printf("\nEnter a: ");
    scanf("%f", &a);
    printf("Enter b: ");
    scanf("%f", &b);
    printf("Enter c: ");
    scanf("%f", &c);

    int result;
    result = calculateQuadraticEquation(a, b, c, &x1, &x2);
    switch (result) {
        case 0:
            printf("Equation has an unique root x = %f", x1);
            break;
        case 1:
            printf("Equation has two roots x1 = %f, x2 = %f", x1, x2);
            break;
        case -1:
            printf("Equation has no roots");
            break;
        default:
            printf("An exceptional answer: %d", result);
    }
}

// MARK: - Calculation functions

void swapValuesOfVariablesByAddress(int *x, int *y) {
    *x ^= *y;
    *y ^= *x;
    *x ^= *y;
}

float maxOfPair(float a, float b) {
    if (a > b) {
        return a;
    } else {
        return b;
    }
};

int calculateQuadraticEquation(float a, float b, float c, float *x1, float *x2) {
    double D;
    D = b * b - 4 * a * c;

    if (a == 0) {
        *x1 = - c / b;
        return 0;
    } else if (D > 0) {
        *x1 = (- b + sqrt(D)) / (2 * a);
        *x2 = (- b - sqrt(D)) / (2 * a);
        return 1;
    } else if (D == 0) {
        *x1 = - b / (2 * a);
        return 0;
    } else {
        return -1;
    }
}


