//: Playground - noun: a place where people can play

import UIKit

struct Stack<T> {
  var array = [T]()
  
  var isEmpty: Bool {
    return array.isEmpty
  }
  
  var count: Int {
    return array.count
  }
  
  mutating func push(_ element: T) {
    array.append(element)
  }
  
  mutating func pop() -> T? {
    return array.popLast()
  }
  
  var top: T? {
    return array.last
  }
  
}

enum Ch3Error: Error {
  case Error
}


// 3.1
// Mostly an explanation of the possible solutions you can make
// 3 stacks with a single array
// If non-resizable, you can do it by dividing the array into 3

// 3.2
// Too easy of a question lol
// skip

// 3.3
// Set of stacks
// Assumptions made:
// I assumed if we want to push an element, we want to push to first open stack
// Also assumed that we were ok with stacks not being at full capacity
// Implementation

class SetOfStack<T> {
  
  let stackCapacity: Int
  var stacks: [Stack<T>]?
  
  init(stackCapacity: Int) {
    self.stackCapacity = stackCapacity
  }
  
  func push(data: T) {
    if stacks == nil {
      var newStack = Stack<T>()
      newStack.push(data)
      stacks = [newStack]
    } else {
      var firstOpenStack = findFirstOpenStack()
      if firstOpenStack == nil {
        var newStack = Stack<T>()
        newStack.push(data)
        stacks?.append(newStack)
      } else {
        firstOpenStack?.push(data)
      }
    }
  }
  
  func findFirstOpenStack() -> Stack<T>? {
    for stack in self.stacks! {
      if stack.count != stackCapacity {
        return stack
      }
    }
    return nil
  }
  
  func pop() -> T? {
    var lastStack: Stack<T> = (stacks?.last)!
    return lastStack.pop()!
  }
  
  func popAt(index: Int) throws -> T? {
    if index > (stacks?.count)! {
      throw Ch3Error.Error
    }
    var stack: Stack<T> = (stacks?[index])!
    
    return stack.pop()
  }
  
}

// 3.4
// Make a queue using 2 stacks
// Idea: just push onto first stack for enqueue. for dequeue. pop/push onto second stack
// pop last value and push everything back to first stack.
class MyQueue<T> {
  var firstStack = Stack<T>()
  var secondStack = Stack<T>()
  
  func enqueue(data: T) {
    firstStack.push(data)
  }
  
  func dequeue() -> T? {
    while !firstStack.isEmpty {
      secondStack.push(firstStack.pop()!)
    }
    let element = secondStack.pop()!
    while !secondStack.isEmpty {
      firstStack.push(secondStack.pop()!)
    }
    return element
  }
  
}

// 3.5
// Sort a stack with smallest elemnt on top, using only 1 additional stack
// Idea: while left stack is not empty, pop, and check with top element on the sorted stack
// if greater than it, push all values < than that popped on to the left stack, push the
// greatest onto sorted and push all values back onto right stack while keeping track
// of smallest one
// Implementation
func sortStack(stack: Stack<Int>) -> Stack<Int> {
  var currStack = stack
  var sortedStack = Stack<Int>()
  while !currStack.isEmpty {
    let sortedTopVal = sortedStack.top
    let popped = currStack.pop()!
    if sortedTopVal == nil || popped < sortedTopVal! {
      sortedStack.push(popped)
    } else {
      var currentValue = sortedStack.pop()
      while currentValue! < popped {
        currStack.push(currentValue!)
        currentValue = sortedStack.pop()
      }
      var topOfCurrent = currStack.pop()
      while topOfCurrent != sortedTopVal {
        sortedStack.push(topOfCurrent!)
        topOfCurrent = currStack.pop()
      }
    }
  }
  return sortedStack
}

// 3.6
// Animal shelter based on arrival time
// Basically just implement 2 queue with cat and dog along with time stamp
// compare the two when any, otherwise dequue from selected queue




