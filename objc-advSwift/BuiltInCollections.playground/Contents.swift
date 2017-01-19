//: Playground - noun: a place where people can play

import UIKit

//
// Maps
//
let fibs: [Int] = [0, 1, 1, 2, 3, 5]

// Before
var squared: [Int] = []
for fib in fibs {
  squared.append(fib * fib)
}

// After
let squares = fibs.map({fib in fib * fib})
print(squares)



// Make this easier
let names = ["Paula", "Elena", "Zoe"]
var lastNameEndingInA: String?
for name in names.reversed() where name.hasSuffix("a") {
  lastNameEndingInA = name
  break
}

print(lastNameEndingInA!)

extension Sequence {
  func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
    for element in reversed() where predicate(element) {
      return element
    }
    return nil
  }
}

let newWayOfLastNameEndingInA = names.last { (n) -> Bool in
  n.hasSuffix("a")
}
print(newWayOfLastNameEndingInA!)

// Filter

let nums = [1, 2, 3, 4, 5, 6, 7, 8]
let filtered = nums.filter { num in num % 2 == 0 }
print(filtered)

// Reduce
let fibss = [0, 1, 1, 2, 3, 5, 8, 13]
let sum = fibss.reduce(0) { (total, n) -> Int in
  return total + n
}
print(sum)

let test = { (x: Int, y: Int) -> Int in
  return x + y
}

print(test(3, 4))


// test forEach
extension Array where Element: Equatable {
  func index(of element: Element) -> Int? {
    for idx in self.indices where self[idx] == element {
      return idx
    }
    return nil
  }
}

let testArray = [1,3,5,6,1,3,2,1,7]
print(testArray.index(of: 1)!)

(1..<10).forEach { (t) in
  print(t)
  if t > 2 { return }
}

