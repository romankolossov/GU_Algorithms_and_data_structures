import UIKit

// Roman Kolosov
// Algorithms. Home work 6

// MARK: - Task 1

// Task 1. Create a simple hash function.
// Input is a string, output is a sum of codes of the string symbols.

print("Task 1. Simple hash function implementation\n")

func hash(of string: String) -> String {
    // The hash contains 24 digits or 12 two-digits hexadecimal numbers.
    // Use reverse order.
    let keyArray: Array<Int> = (1...12).map { $0 }.reversed()
    
    var sumUSV: Int = 0
    // Sum of iteger unicode scalar values of the entered string.
    string.unicodeScalars.forEach { scalar in
        sumUSV += Int(scalar.value)
    }
    var hash: String = ""
    
    // Maximal two-digits hexadecimal number is FF or 255 as decimal one.
    // To limit by 255, % is used.
    keyArray.forEach{
        let partOfHash = String(format:"%2X", ($0 * sumUSV) % 255)
        // Fill empty places ot the first digits of the partOfHash by 0 if it is in range of 0...9.
        partOfHash.forEach {
            if $0 == " " {
                hash.append("0")
            } else {
                hash.append($0)
            }
        }
    }
    print("\nExpression to hash: '\(string)'")
    print("Sum of itegers of unicode scalar values of the entered expression:")
    print(" in decimal: \(sumUSV)")
    print(" in hexadecimal: \(String(format:"%2X", sumUSV))")
    
    return hash
}

// MARK: Task 1 implementation

print("Hash: ", hash(of: "Hello, everybody!! I am soo glad to see you! Take care and have a good day!!!"))
print("Hash: ", hash(of: "!"))
print("Hash: ", hash(of: "!!!"))


// MARK: - Task 2

// Task 2. Rewrite the programm of the binary search tree.
// Add different binary search tree traversals.
// Implement searching in the binary search tree.

print("\n\nTask 2. Rewriting the programm of the binary search tree with implementation:\n Different binary search tree traversals\n Search in the binary search tree")

/*
Binary tree
 An empty structure it is a binary tree.
 Binary tree it is a root and two related to it binary trees (left and right ones)
 
The binary search tree
 On the left from each node are located nodes with values less or equal to the value of the node.
 On the right from each node are located nodes with values more than the value of the node.
 
Create a balanced tree for an effective search in it.

Roules for a balanced tree with n nodes
 Use one root node
 Create the right sub tree with number of nodes nl=n div 2
 Create the right sub tree with number of nodes nr=n-nl-1
*/

// MARK: - Public classes

final class Node {
    
    let value: Int
    var leftSon: Node?
    var rightSon: Node?
    var parent: Node?
    
    init(value: Int, leftSon: Node? = nil, rightSon: Node? = nil, parent: Node? = nil) {
        self.value = value
        self.leftSon = leftSon
        self.rightSon = rightSon
        self.parent = parent
    }
}

final class Three {
    var root: Node?
    
    init(root: Node? = nil) {
        self.root = root
    }
}

// MARK: - Public variables

// Array of 100 random intengers in 1...100.
let inputArray: Array<Int> = (1...100).map { _ in
    Int.random(in: 1..<100)
}
var bool = true // Indicates wether the tree is balanced.
var startCount = 0 // How many times createTree() called

var treeArray = [Node]()
var treeNode = [Node]()

var treeTwoNillLeafs = [Node]()
var treeOneNillLeaf = [Node]()

// Create instance.
let tree = Three()

// MARK: - Public functions

func createThree(array: [Int], parent: Node?) -> Node? {
    startCount += 1
    if array.count > 3 {
        let sorted = array.sorted { $0 < $1 }
        var center = sorted.count / 2
        
        for i in (sorted.count / 2)...(sorted.count - 1) {
            if i < sorted.count - 1 {
                if sorted[i] != sorted[i+1] {
                    break
                }
                if sorted[i] == sorted[i+1] {
                    center = i + 1
                }
            }
        }

        var nl = [Int]()
        for i in 0...(center - 1) { nl.append(sorted[i]) }
        var nr = [Int]()
        if (sorted.count - 1 - center) > 0 {
            for i in (center + 1)...(sorted.count - 1) { nr.append(sorted[i]) }
        }
    
        var root = Node(value: sorted[center], leftSon: nil, rightSon: nil, parent: parent)
        
        if (sorted.count / 2) == center {
            bool == true ? print("Congratulation! The tree is balanced") : nil
            bool = false
        } else {
            bool == true ? print("The tree is unbalanced") : nil
            bool = false
        }
    
        let leftSon = createThree(array: nl, parent: root)
        let rightSon = createThree(array: nr, parent: root)
        root = Node(value: sorted[center], leftSon: leftSon, rightSon: rightSon, parent: parent)
        
        tree.root = root
        treeArray.append(root)
        return root
       
    } else if array.count == 1 {
        let root = Node(value: array[0], leftSon: nil, rightSon: nil, parent: parent)
        treeArray.append(root)
        return root
    } else if array.count == 2 {
        let sorted = array.sorted { $0 < $1 }
        var root = Node(value: sorted[1], leftSon: nil, rightSon: nil, parent: parent)
        let leftSon = Node(value: sorted[0], leftSon: nil, rightSon: nil, parent: root)
        root = Node(value: sorted[1], leftSon: leftSon, rightSon: nil, parent: parent)
        treeArray.append(root)
        treeArray.append(leftSon)
        return root
    } else if array.count == 3 {
        let sorted = array.sorted { $0 < $1 }
        var root = Node(value: sorted[1], leftSon: nil, rightSon: nil, parent: parent)
        let leftSon = Node(value: sorted[0], leftSon: nil, rightSon: nil, parent: root)
        let rightSon = Node(value: sorted[2], leftSon: nil, rightSon: nil, parent: root)
        root = Node(value: sorted[1], leftSon: leftSon, rightSon: rightSon, parent: parent)
        treeArray.append(root)
        treeArray.append(leftSon)
        treeArray.append(rightSon)
        return root
    }
    
    return nil
}

func printTree(root: Node?) {
    if let node = root {
        print("\(node.value)", terminator: "")
        if node.leftSon != nil || node.rightSon != nil {
            print("(", terminator: "")
            if node.leftSon != nil {
                printTree(root: node.leftSon)
            } else {
                print("NIL", terminator: "")
            }
            print(",", terminator: "")
            
            if node.rightSon != nil {
                printTree(root: node.rightSon)
            } else {
                print("NIL", terminator: "")
            }
            print(")", terminator: "")
            
        }
    }
}

func rootLeftRight(root: Node?) {
    if let node = root {
    print("\(node.value)", terminator: " ")
        rootLeftRight(root: node.leftSon)
        rootLeftRight(root: node.rightSon)
    }
}

func leftRootRight(root: Node?) {
    if let node = root {
        rootLeftRight(root: node.leftSon)
        print("\(node.value)", terminator: " ")
        rootLeftRight(root: node.rightSon)
    }
}

func leftRightRoot(root: Node?) {
    if let node = root {
        rootLeftRight(root: node.leftSon)
        rootLeftRight(root: node.rightSon)
        print("\(node.value)", terminator: " ")
    }
}

func searchInTree(root: Node?, value: Int) {
    guard let node = root else {
        print("Value \(value) is not found in the tree")
        return
    }
    if value == node.value {
        print(" value \(value) found in node:")
        print(" \(node)")
        // In the left may be nodes equal to the node found. So we need to chack it.
        guard let leftNode = node.leftSon?.value else {
            print("\(node). It is a leaf with value \(value)")
            return
        }
        if value == leftNode {
            searchInTree(root: node.leftSon, value: value)
        }
    } else if value > node.value {
        searchInTree(root: node.rightSon, value: value)
    } else if value < node.value {
        searchInTree(root: node.leftSon, value: value)
    }
}

// MARK: - Extensions

extension Node: CustomStringConvertible {
    var description: String {
        var description = "Node \(Unmanaged.passUnretained(self).toOpaque()) has value \(value)"
        if let leftSon = leftSon {
            description = description + ", with left son value \(leftSon.value)"
        }
        if let rightSon = rightSon {
            description = description + ", with right son value \(rightSon.value)"
        }
        return description
    }
}


// MARK: - Task 2 implementation

// MARK: Binary tree creation and description

print("\nInput data array contains \(inputArray.count) items with values:")
print(inputArray)

print("\nBinary search tree creation")
startCount = 0
createThree(array: inputArray, parent: nil)

print(" Value of the root: \(tree.root?.value ?? 0)")
print(" Recursive function calls: \(startCount)")
print(" Nodes created: \(treeArray.count)")

print("\nBinary search tree description")

treeArray.forEach { if $0.parent == nil { print("The root node has value: \($0.value)") } }
treeArray.forEach { if $0.leftSon == nil { if $0.rightSon == nil { treeTwoNillLeafs.append($0) } } }
treeArray.forEach { if $0.leftSon == nil { if $0.rightSon != nil { treeOneNillLeaf.append($0) } } }
treeArray.forEach { if $0.leftSon != nil { if $0.rightSon == nil { treeOneNillLeaf.append($0) } } }
treeArray.forEach { if $0.leftSon != nil { if $0.rightSon != nil { treeNode.append($0) } } }

print(" Number of leafs: \(treeTwoNillLeafs.count)")
print(" Number of nodes having just one leaf: \(treeOneNillLeaf.count)")
print(" Number of full value parents: \(treeNode.count)")

print("\nBinary search tree verification status")
if (treeTwoNillLeafs.count + treeOneNillLeaf.count + treeNode.count) == inputArray.count {
    print(" Verification success")
} else {
    print(" Verification error")
}

print("\nBinary search tree expression")
printTree(root: tree.root)

// MARK: Binary tree recursive traversal

print("\n\n\nBinary tree recursive traversal")
print("\nPre-order, Root -> Left -> Right")
rootLeftRight(root: tree.root)

print("\n\nIn-order, Left -> Root -> Right")
leftRootRight(root: tree.root)

print("\n\nPost-order, Left -> Right -> Root")
leftRightRoot(root: tree.root)

// MARK: Value search in the binary search tree

print("\n\n\nValue search in the binary search tree")

// Create value to search in the range of 30...70.
let searchValue = Int.random(in: 30..<70)

print(" Value to search: \(searchValue)")
searchInTree(root: tree.root, value: searchValue)

