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