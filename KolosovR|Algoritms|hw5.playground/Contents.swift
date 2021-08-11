// Kolosov Roman
// Algorithms. Home work 5

import UIKit

// MARK: - Public collections

enum PushNodeError: Error {
    case noMemoryAllocated
}

enum BracketError: Error {
    case bracketSequenceValidationFailure
}

// MARK: - Public classes

final class Node {
    let value: Int
    var nextNode: Node?
    
    init(value: Int, nextNode: Node? = nil) {
        self.value = value
        self.nextNode = nextNode
    }
}

final class SinglyLinkedList {
    var firstNode: Node?
    
    init(firstNode: Node? = nil) {
        self.firstNode = firstNode
    }
}

// MARK: - Major public functions

// Push a node in the singly linked list in a stack way.
func pushNode(value: Int, list: SinglyLinkedList) throws {
    guard let currentNode = list.firstNode else {
        let firstNode = Node(value: value)
        list.firstNode = firstNode
        return
    }
    let newNode = Node(value: value, nextNode: currentNode)
    list.firstNode = newNode
}

// Print nodes in the singly linked list in a stack way.
func printNodes(list: SinglyLinkedList) {
    guard var entity = list.firstNode else {
        print("Stack is empty")
        return
    }
    var isContinue = true
    repeat {
        print("\(entity.value)", terminator: "")
        guard let newEntity = entity.nextNode else {
            isContinue = false
            print("\n")
            return
        }
        entity = newEntity
    } while isContinue
}

// Decimal number to binary convertion with use of the stack built on the singly linked list.
func decimalToBinary(value: Int, list: SinglyLinkedList) {
    var int = value
    
    if int > -1 {
        while int != 0 {
            if int % 2 == 1 {
                do {
                    try pushNode(value: 1, list: list)
                } catch {
                    print(PushNodeError.noMemoryAllocated)
                }
            } else {
                do {
                    try pushNode(value: 0, list: list)
                } catch {
                    print(PushNodeError.noMemoryAllocated)
                }
            }
            int = int / 2
        }
        printNodes(list: list)
    } else {
        print("incorrect Int")
    }
}

// MARK: - Extensions

// Decribe Node type object.
extension Node: CustomStringConvertible {
    var description: String {
        // The address of allocated memory of the Node.
        let message = "Node \(Unmanaged.passUnretained(self).toOpaque()) has value \(value) with "

        guard let nextNode = nextNode else {
            return message + "no next node"
        }
        return message + "next node value \(nextNode.value)"
    }
}

// Describe SinglyLinkedList type object.
extension SinglyLinkedList: CustomStringConvertible {
    var description: String {
        // The address of allocated memory of the SinglyLinkedList.
        var description = "List \(Unmanaged.passUnretained(self).toOpaque()) has "
        guard var node = firstNode else {
            return description + "no nodes"
        }
        description += "nodes:\n"
        
        var isContinue = true
        repeat {
            description += (node.description + "\n")
            guard let nextNode = node.nextNode else {
                isContinue = false
                return description
            }
            node = nextNode
        } while isContinue
        
        return description
    }
}

// MARK: - Implementation of the home work tasks

// Create SinglyLinkedList type instance.
let list = SinglyLinkedList()

// Task 1. Decimal to binary convertion using the stack

print("Task 1. Decimal to binary convertion using the stack\n")
let decimalNumber = 1368
print("Decimal number: ", decimalNumber)
print("Binary number: ")
decimalToBinary(value: decimalNumber, list: list)

// Task 2. Create a stack on the base of the singly linked list.
// Check the memory allocation for it and notify if no memory allocation done.

print("Task 2. Stack creation on the base of the singly linked list\n")
print(String(describing: list))

// Task 3. Check the bracket sequence for its validity
// Correct bracket sequence: (), ([])(), {}(), ([{}])
// Wrong bracket sequence: )(, ())({), (, ])}), ([(]) для скобок [, (, {.
// Ex: (2+(2*2)) или [2/{5*(4+7)}].

print("Task 3. Bracket sequence validity check\n")
let inputString = "[2/{5*(4+7)}]"

let closingBrackets: [Character] = [")","]","}"]
let allBrackets: [Character] = ["(","[","{",")","]","}"]

var bracketArray: Array<Character> = inputString.filter {
    allBrackets.contains($0)
}

var i = 0
repeat {
    guard !closingBrackets.contains(bracketArray[i]) else {
        print("Incorrect bracket sequence")
        break
    }
    switch bracketArray[i] {
    case "(":
        if bracketArray[i+1] == ")" {
            bracketArray.remove(at: i)
            bracketArray.remove(at: i)
            i = 0
            continue
        }
    case "[":
        if bracketArray[i+1] == "]" {
            bracketArray.remove(at: i)
            bracketArray.remove(at: i)
            i = 0
            continue
        }
    case "{":
        if bracketArray[i+1] == "}" {
            bracketArray.remove(at: i)
            bracketArray.remove(at: i)
            i = 0
            continue
        }
    default:
        print("Error: incorrect bracket symbol")
    }
    i += 1
    
} while i < bracketArray.count

guard bracketArray.count == 0 else {
    throw BracketError.bracketSequenceValidationFailure
}
print("Bracket validation of the expression \(inputString) passed")



