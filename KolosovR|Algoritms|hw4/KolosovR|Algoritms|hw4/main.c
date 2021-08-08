//
//  main.c
//  KolosovR|Algoritms|hw4
//
//  Created by Roman Kolosov on 07.08.2021.
//

#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
// Home work of the lesson 4 by Roman Kolosov

int menu(void);
void task1(void);

// MARK: - Main function

int main(int argc, const char * argv[]) {
    int task;

    do {
        task = menu();

        switch (task) {
            case 1:
                task1();
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

    printf("\n\n1 - Task 1. Number of routes with barriers\n");
    printf("0 - Exit\n");

    do {
        scanf("%i", &task);
        getchar();
        if (task < 0 || task > 1) {
            printf("Please, enter 1 or 0 for exit\n");
        }
    } while (task < 0 || task > 1);

    return  task;
}

// MARK: - Task functions

void task1() {
    printf("Task 1. Number of routes with barriers");
    printf("\nThis programm will calculate the number of routes with barriers");

    int xMax, yMax, numberOfBarriers;
    int placedBarrierCounter, setBarrierAttemptCounter;
    int const maxAttempsToSetBarriers = 368;

    printf("\n\nEntering the dimensions of the route map");
    printf("\nPlease, enter the dimension by x, in cells: ");
    scanf("%d", &xMax);
    printf("Please, enter the dimension by y, in cells: ");
    scanf("%d", &yMax);

    printf("Please, entering the number of barriers, less than %d: ", xMax * yMax);
    scanf("%d", &numberOfBarriers);

    // Define the route map array.
    int routeMap[yMax][xMax];

    // Fill all route map array by the value of 1. It is where we can move.
    for (int y = 0; y < yMax; y++) {
        for (int x = 0; x < xMax; x++) {
            routeMap[y][x] = 1;
        }
    }

    // Fill the route map randomly by the value of 0 where barriers are.
    // It means we can not move where amount of numberOfBarriers is placed.
    placedBarrierCounter = 0;
    setBarrierAttemptCounter = 0;

    while (placedBarrierCounter < numberOfBarriers) {
        // Get a random x between 0 and xMax - 1.
        int x = rand() % xMax;
        int y = rand() % yMax;
//        printf("x = %d y= %d", x + 1, y + 1);
//        printf("\n");

        // Not to place a barrier in the first and the last cells of the route map.
        // The board with the zero cell in the upper left coner is represented by the route map. Respectively, the last cell is in the bottom right coner.
        if (x == 0) {
            if (y == 0) {
                setBarrierAttemptCounter++;
                continue;
            }
        } else if (x == (xMax - 1)) {
            if (y == (yMax -1)) {
                setBarrierAttemptCounter++;
                continue;
            }
        } else if (routeMap[y][x] != 0) {
            routeMap[y][x] = 0;
            placedBarrierCounter++;
        }
        if (setBarrierAttemptCounter >= maxAttempsToSetBarriers) {
            printf("Error: Maximal number of attempts to set barriers is exceeded\n");
            break;
        }
    }

    // Print the route map array.
    printf("\nThe route map is:\n");
    for (int y = 0; y < yMax; y++) {
        for (int x = 0; x < xMax; x++) {
            printf("%d ", routeMap[y][x]);
        }
        printf("\n");
    }

    // Modify the route map array.
    for (int y = 1; y < (yMax - 1); y++) {
        if (routeMap[y][0] == 0) {
            routeMap[y+1][0] = 0;
        }
    }
    for (int x = 1; x < (xMax - 1); x++) {
        if (routeMap[0][x] == 0) {
            routeMap[0][x+1] = 0;
        }
    }

    // Calculate the number of leaps for each cell of the route map.
    for (int y = 1; y < yMax; y++) {
        for (int x = 1; x < xMax; x++) {
            if (routeMap[y][x] != 0)
                routeMap[y][x] = routeMap[y][x-1] + routeMap[y-1][x];
        }
    }

    // Print the route map array with the number of leaps for each cell in it.
    printf("\nLeap matrix: \n");

    for (int y = 0; y < yMax; y++) {
        for (int x = 0; x < xMax; x++) {
            printf("%d   ", routeMap[y][x]);
        }
        printf("\n\n");
    }

}




