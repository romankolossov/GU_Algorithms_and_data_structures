import UIKit

// Roman Kolosov
// Algorithms home work 7

// MARK: Task 1. Write functions for reading the adjacency matrix of a graph from a file and showing it on the screen.

print("Task 1. Read the matrix from a file")

// MARK: - Read from file function

@discardableResult func readFromFile() -> [Int]? {
    // Read data from textPlain.txt file located in Resources folder of the project.
    //  separate the text by lines separated by "\n"
    //  the resulting lines separate to another lines separated by " "
    //  remove empty elements ""
    //  create new array of Ints.

    let matrixSize: Int
    let unicodeScalarOfLetterA: Int = 65

    var tmpArr = [String]()
    var resultArr = [Int]()
    var vertexLetters = [Character]()
    var j: Int

    guard let pathT = Bundle.main.path(forResource: "textPlain", ofType: "txt"),
          let textT = try? String(contentsOfFile: pathT)
    else {
        print("Error in reading file")
        return nil
    }
    textT.components(separatedBy: "\n").forEach{ tmpArr += $0.components(separatedBy: " ") }
    resultArr = tmpArr.filter { $0 != ""}.map { Int($0) ?? 0 }
    
    // The matrix size is indicated in the upper left corner in the .txt file and stored in resultArray[0].
    matrixSize = resultArr.first ?? 0

    // Check wether the data exists and matrix size is correct.
    guard resultArr.count != 0,
          NSDecimalNumber(decimal: pow(Decimal(matrixSize), 2)).intValue == (resultArr.count - 1)
    else {
        print("Error in reading matrix")
        return nil
    }
    print("\nMatrix reading from file succeeded")
    print("Matrix size \(matrixSize) x \(matrixSize) with \(resultArr.count - 1) elements\n")

    // Create the array of markers A,B,C, ... of the graph vertices with number of elements in it equal to the matrix size.
    (0..<matrixSize).forEach { i in
        vertexLetters.append( Character(UnicodeScalar(i + unicodeScalarOfLetterA) ?? "A") )
    }
    print(" ", terminator: "  ")

    // Print the upper line of the matrix with markers of its vertices.
    vertexLetters.forEach { letter in
        print(letter, terminator: "  ")
    }
    print()

    // Print the matrix with values and markers of vertices for the columns.
    j = 0
    (1..<resultArr.count).forEach { i in
        if i % matrixSize == 1 {
            print(vertexLetters[j], terminator: "  ")
            j += 1
        }
        print(resultArr[i], terminator: "  ")
        if i % matrixSize == 0 {
            print()
        }
    }
    print()
    return resultArr
}

// MARK: - Task 1 imlementation

let adjacencyMatrixArr = readFromFile()


// MARK: Task 2. Write a function implementing the recursive in depth-first traversal algorithm for a graph.

print("\nTask 2. Implementation the recursive in depth-first traversal algorithm for a graph")
print("Depth-first search (DFS) algorithm\n")

// MARK: - Some collections

enum AdjacencyMatrixError: Error {
    case adjacencyMatrixArrayInvalid
}

// MARK: - Some variables

var vertexLetters = [Character]()
var processDFS = [Bool]() // Depth-first search (DFS) array of check points for each vertex.

let unicodeScalarOfLetterA: Int = 65
var sumOfEdgeLengths: Int = 0  // Length of all edges traversed.

// MARK: - Major functions

// MARK: Depth-first search graph traversal recursive function

func graphTraversalInDepth(matrix array: [Int], with matrixSize: Int,
                           startFrom vertex: Int, edgeLength sum: Int) {
    // Consistently traverse all vertexes which are avaliable from the start vertex.
    // If the edge leads to the undiscovered before vertex then the algorithm starts from this vertex.
    // If there is no more edges leading to undiscovered vertex then we go back.

    guard array.count != 0 else {
        return
    }

    // Check wether the vertex is not yet visited.
    guard processDFS[vertex] == false else {
        return
    }
    // Mark the vertex as checked and calculate the new edge length sum.
    print("Vertex \(vertexLetters[vertex]) checked")
    processDFS[vertex] = true
    sumOfEdgeLengths += sum

    (1...matrixSize).forEach { i in
        if array[i + (vertex * matrixSize)] != 0 {
            let newVertex = i - 1
            let edges = array[i + (vertex * matrixSize)]
            graphTraversalInDepth(matrix: array, with: matrixSize,
                                  startFrom: newVertex, edgeLength: edges)
        }
    }
}

// MARK: - Task 2 implementation

guard let matrixArr = adjacencyMatrixArr,
      let matrixSize = matrixArr.first
else {
    throw AdjacencyMatrixError.adjacencyMatrixArrayInvalid
}
print("It is \(matrixSize) vertices in the graph\n")

// Create the array of markers A,B,C, ... of the graph vertexes with number of elements in it equal to the matrix size.
(0..<matrixSize).forEach { i in
    vertexLetters.append( Character(UnicodeScalar(i + unicodeScalarOfLetterA) ?? "A") )
}

// Create an array of check points for each vertex.
processDFS = (0..<vertexLetters.count).map { _ in
    false
}
sumOfEdgeLengths = 0

// In depth-first graph traversal method call.
graphTraversalInDepth(matrix: matrixArr, with: matrixSize, startFrom: 0, edgeLength: 0)

// Check for unvisited vertices if any.
(0..<processDFS.count).forEach { i in
    processDFS[i] == true ? nil : print("Vertex \(vertexLetters[i]) is not checked")
}
print("\nLength of all edges traversed: \(sumOfEdgeLengths)\n")


// MARK: Task 3. Write a function implementing the in breadth-first search traversal algorithm for a graph.

print("\nTask 3. Implementation the in breadth-first traversal algorithm for a graph")
print("Breadth-first search (BFS) algorithm\n")

// MARK: - Some variables

var processBFS = [Int]() // Array of check points for each vertex.
var sumOfEdgeLengthsFromBFS: Int

// MARK: - Major functions

func logicBFS(matrix array: [Int], vertex: Int, sumOfEdgeLengths: inout Int) {
    /*
    Firstly adjacent vertices to the current vertex are visited.
     After its children vertices are visited.
     Some meaning of:
    0 — the vertex is not yet reached by the wave
    1 — the vertex is in the front of the wave
    2 — the wave left the vertex
    */
    guard array.count != 0 else {
        return
    }
    // Check wether the vertex was visited before.
    guard processBFS[vertex] != 2 else {
        return
    }
    if processBFS[vertex] == 1 {
        // Mark the vertex as checked.
        print("Vertex \(vertexLetters[vertex]) checked")
        processBFS[vertex] = 2
    }
    (1...5).forEach { i in
        if array[i + (vertex * 5)] != 0 {
            if processBFS[i-1] == 0 {
                // Mark the adjacent vertices of the graph.
                processBFS[i-1] = 1
                sumOfEdgeLengths += array[i + (vertex * 5)]
            }
        }
    }
}

func graphTraversalInBreadth(sumOfEdgeLengths: inout Int) {
    var nextVertices = [Int]()

    repeat {
        nextVertices = []

        // Add to the queue array the vertices which are in the wave front.
        (0..<processBFS.count).forEach { i in
            if processBFS[i] == 1 { nextVertices.append(i) }
        }
        // Breadth-first graph traversal algorithm implement for the vertices.
        guard nextVertices.count > 0 else {
            break
        }
        (0..<nextVertices.count).forEach { i in
            logicBFS(matrix: matrixArr, vertex: nextVertices[i],
                     sumOfEdgeLengths: &sumOfEdgeLengths)
        }
    } while true
}

// MARK: - Task 3 implementation

print("It is \(matrixSize) vertices in the graph\n")

// Create an array of check points for each vertex.
processBFS = (0..<vertexLetters.count).map { _ in 0 }
// Start rom the first vertex. Set to zero the total length of all edges.
processBFS[0] = 1
sumOfEdgeLengthsFromBFS = 0

// Breadth-first graph traversal algorithm method call.
graphTraversalInBreadth(sumOfEdgeLengths: &sumOfEdgeLengthsFromBFS)

// Check for unvisited vertices if any.
(0..<processBFS.count).forEach { i in
    processBFS[i] == 2 ? nil : print("Vertex \(vertexLetters[i]) not checked")
}
print("\nLength of all edges traversed \(sumOfEdgeLengthsFromBFS)\n")

