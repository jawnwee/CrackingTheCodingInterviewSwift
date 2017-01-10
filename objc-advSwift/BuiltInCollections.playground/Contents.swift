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


