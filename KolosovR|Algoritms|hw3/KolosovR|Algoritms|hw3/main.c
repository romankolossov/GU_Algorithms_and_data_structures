//
//  main.c
//  KolosovR|Algoritms|hw3
//
//  Created by Roman Kolosov on 01.08.2021.
//

#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
// Home work of the lesson 3 by Roman Kolosov

int menu(void);
void task1(void);
void task2(void);

void optimisedBubleSort(int arr[], int n);
void bubleSort(int arr[], int n);

void swap(int *xPointer, int *yPointer);
void printArray(int arr[], int size);

int binarySearch(int a, int arr[], int n);

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

    printf("\n\n1 - Task 1. Buble array sort optimisation\n");
    printf("2 - Task 2. Binary search algorithm\n");
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
    printf("Task 1. Buble array sort optimisation");
    printf("\nThis programm will compare buble array sort with its optimased version");

    int arr[] = {64, 34, 25, 12, 22, 11, 90, 88, 3, 6, 8};
    int arr2[] = {64, 34, 25, 12, 22, 11, 90, 88, 3, 6, 8};

    int n = sizeof(arr) / sizeof(arr[0]);
    int n2 = sizeof(arr2) / sizeof(arr2[0]);

    // Buble sort.
    printf("\n\nOriginal array:\n");
    printArray(arr, n);

    bubleSort(arr, n);

    printf("\nSorted array by buble sort:\n");
    printArray(arr, n);

    // Optimised buble sort.
    printf("\n\nOriginal array:\n");
    printArray(arr2, n2);

    optimisedBubleSort(arr2, n2);

    printf("\nSorted array by optimised buble sort:\n");
    printArray(arr2, n2);
}

void task2() {
    printf("Task 2. Binary search algorithm");
    printf("\nThis programm will implement the binary search algorithm");

    int numberToSearch;
    int index;

    int arr[] = {64, 34, 25, 12, 22, 11, 90, 88, 3, 6, 8};
    int n = sizeof(arr) / sizeof(arr[0]);

    printf("\n\nAscending arry sort done to implement the binary search algorithm");
    optimisedBubleSort(arr, n);

    printf("\n\nSorted array:\n");
    printArray(arr, n);

    printf("\nPlese, enter a number in the array to search: ");
    scanf("%d", &numberToSearch);

    index = binarySearch(numberToSearch, arr, n);

    if (index == -1) {
        printf("Value not found");
    } else {
        printf("Value: %d at Index: %d", arr[index], index);
    }
}

// MARK: - Calculation functions

int binarySearch(int a, int arr[], int n) {
    int low, high, middle;
    low = 0;
    high = n - 1;

    while (low <= high) {
        middle = (low + high) / 2;
        if (a < arr[middle])
            high = middle - 1;
        else if (a > arr[middle])
            low = middle + 1;
        else
            return middle;
    }
    return -1;
}

void bubleSort(int arr[], int n) {
    int i, j;
    int cycleCounter = 0;
    int conditionCounter = 0;
    
    for (i = 0; i < n; i++) {
        for (j = 0; j < (n - 1); j++) {
            if (arr[j] > arr[j+1]) {
                swap(&arr[j], &arr[j+1]);
                conditionCounter++;
            }
            cycleCounter++;
        }
    }
    printf("\nBuble sort");
    printf("\nNuber of elements: %d ", n);
    printf("\nCycle use, in times: %d ", cycleCounter);
    printf("\nCondition use, in times: %d ", conditionCounter);
}

void optimisedBubleSort(int arr[], int n) {
    int i, j;
    int cycleCounter = 0;
    int conditionCounter = 0;
    
    for (i = 0; i < (n - 1); i++) {
        for (j = 0; j < (n - i - 1); j++) {
            if (arr[j] > arr[j+1]) {
                swap(&arr[j], &arr[j+1]);
                conditionCounter++;
            }
            cycleCounter++;
        }
    }
    printf("\nOptimised buble sort");
    printf("\nNuber of elements: %d ", n);
    printf("\nCycle use, in times: %d ", cycleCounter);
    printf("\nCondition use, in times: %d ", conditionCounter);
}

void swap(int *xPointer, int *yPointer) {
    int temp = *xPointer;
    *xPointer = *yPointer;
    *yPointer = temp;
}

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++)
        printf("%d ", arr[i]);
}

