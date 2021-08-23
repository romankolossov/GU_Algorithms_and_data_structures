import UIKit

// Roman Kolosov
// Algorithms home work 8

// MARK: - Major variables

// Create arrays to sort.
var arrayToSortOf100: Array<Int> = (0..<100).map { _ in
    Int.random(in: 0..<100)
}
var arrayToSortOf1_000: Array<Int> = (0..<1_000).map { _ in
    Int.random(in: 0..<100)
}
var arrayToSortOf10_000: Array<Int> = (0..<10_000).map { _ in
    Int.random(in: 0..<100)
}
var arrayToSortOf100_000: Array<Int> = (0..<100_000).map { _ in
    Int.random(in: 0..<100)
}

// MARK: - Task 1. Counting sorting algorithm imlementation.

print("Task 1. Counting sorting\n")

// MARK: - Major functions

func countingSortResult(arrayToSort: [Int], withMaximalElement maxNumber: Int) -> [Int] {
    let sortBeginTime, sortingTime:Double

    var countingArr = [Int]()
    var resultArr = [Int]()
    var numberOfComparisons: Int = 0
    var index: Int = 0

    sortBeginTime = Double(Date().timeIntervalSince1970)
    resultArr = arrayToSort
    countingArr = (0..<(maxNumber + 1)).map{ _ in 0 }

    (0..<resultArr.count).forEach { i in
        numberOfComparisons += 1
        countingArr[resultArr[i]] += 1
    }
    (0..<countingArr.count).forEach { i in
        if countingArr[i] != 0 {
            (0..<countingArr[i]).forEach { _ in
                numberOfComparisons += 1
                resultArr[index] = i
                index += 1
            }
        }
    }
    sortingTime = Double(Date().timeIntervalSince1970) - sortBeginTime
    print("Counting sorting algorithm time performance for \(resultArr.count) elements, in sec.: \(sortingTime)")
    print("Number of comparisons for \(resultArr.count) elements: \(numberOfComparisons)")

    return resultArr
}

// MARK: - Task 1 Imlementation

// Call counting sorting algorithm function.
countingSortResult(arrayToSort: arrayToSortOf100, withMaximalElement: 99)


// MARK: - Task 2. Quick sorting algorithm implementation.

print("\nTask 2. Quick sorting\n")

// MARK: - Some variables

var numberOfComparisons: Int = 0

// MARK: - Major fuctions

func quickSort(arrayToSort: [Int]) -> [Int] {
    numberOfComparisons += 1
    guard arrayToSort.count > 1 else {
        return arrayToSort
    }
    // Set the pivot value as an element in the middle of the array.
    let pivot = arrayToSort[arrayToSort.count / 2]

    var lessArr = [Int]()
    var greaterArr = [Int]()
    var equalArr = [Int]()

    // Sort the elements by the arrays: less, greater or equal ones to the pivot.
    (0..<arrayToSort.count).forEach { i in
        numberOfComparisons += 1
        if arrayToSort[i] == pivot {
            equalArr.append(arrayToSort[i])
        } else {
            numberOfComparisons += 1
            arrayToSort[i] < pivot ?
                lessArr.append(arrayToSort[i]) : greaterArr.append(arrayToSort[i])
        }
    }
    return quickSort(arrayToSort: lessArr) + equalArr + quickSort(arrayToSort: greaterArr)
}

func quickSortResult(arrayToSort: [Int]) {
    numberOfComparisons = 0
    let sortBeginTime = Double(Date().timeIntervalSince1970)

    // Call quick sorting algorithm function.
    quickSort(arrayToSort: arrayToSort)
    let sortingTime = Double(Date().timeIntervalSince1970) - sortBeginTime

    print("Quick sort algorithm time performance for \(arrayToSort.count) elements, in sec.: \(sortingTime)")
    print("Number of comparisons for \(arrayToSort.count) elements: \(numberOfComparisons)")
}

// MARK: - Task 2 Imlementation

// Call the quick sorting result finction to get the sorting result.
quickSortResult(arrayToSort: arrayToSortOf100)


// MARK: - Task 5. Time performance comparison for the counting and quick sorting algorithms.

// Task 5. Compare the time performance of the counting and quick sorting algorithms
// for 100, 1_000, 10_000 and 100_000 elements

// MARK: - Task 5 Imlementation

print("\nTask 5. Time performance comparison for the counting and quick sorting algorithms\n")
print("Kolosov Roman\nIntel Core i5 1.3Ghz\nmacOS Big Sur ver. 11.5.2\nXcode ver. 12.5.1\n")

// Call counting sorting algorithm function.
countingSortResult(arrayToSort: arrayToSortOf100, withMaximalElement: 99)
countingSortResult(arrayToSort: arrayToSortOf1_000, withMaximalElement: 99)
countingSortResult(arrayToSort: arrayToSortOf10_000, withMaximalElement: 99)
countingSortResult(arrayToSort: arrayToSortOf100_000, withMaximalElement: 99)
print()

// Call the quick sorting result finction.
quickSortResult(arrayToSort: arrayToSortOf100)
quickSortResult(arrayToSort: arrayToSortOf1_000)
quickSortResult(arrayToSort: arrayToSortOf10_000)
// quickSortResult(arrayToSort: arrayToSortOf100_000) // Attention: it runs nearly 3 minuts

// MARK: - Task 5 Results
/*
 Kolosov Roman
 Intel Core i5 1.3Ghz
 macOS Big Sur ver. 11.5.2
 Xcode ver. 12.5.1

 Counting sorting algorithm time performance for 100 elements, in sec.: 0.018977880477905273
 Number of comparisons for 100 elements: 200
 Counting sorting algorithm time performance for 1000 elements, in sec.: 0.22693705558776855
 Number of comparisons for 1000 elements: 2000
 Counting sorting algorithm time performance for 10000 elements, in sec.: 1.1127088069915771
 Number of comparisons for 10000 elements: 20000
 Counting sorting algorithm time performance for 100000 elements, in sec.: 11.270267963409424
 Number of comparisons for 100000 elements: 200000

 Quick sort algorithm time performance for 100 elements, in sec.: 0.07478809356689453
 Number of comparisons for 100 elements: 1501
 Quick sort algorithm time performance for 1000 elements, in sec.: 0.943199872970581
 Number of comparisons for 1000 elements: 14275
 Quick sort algorithm time performance for 10000 elements, in sec.: 9.065829038619995
 Number of comparisons for 10000 elements: 131309
 Quick sort algorithm time performance for 100000 elements, in sec.: 186.09755420684814
 Number of comparisons for 100000 elements: 1358665
 */

