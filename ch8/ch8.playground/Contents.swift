//: Playground - noun: a place where people can play

import UIKit

// 8.1
// I already did this problem... just forgot to commit and push on old laptop oops
// Memoization + fib basically

// 8.2
// Given grid with robot on top left, get to the bottom right. There are some restricted spots
// Design algorithm to find a path for robot from top left to bottom right
enum Direction {
  case Right
  case Down
}

enum GridState {
  case Unvisited
  case Valid
  case Invalid
}

func robotGrid(grid: [[Bool]], r: Int, c: Int) -> [Direction] {
  var memoize = [[GridState]](repeating: [GridState](repeating: GridState.Unvisited, count: r), count: c)
  
  func robotGridHelper(path: [Direction], row: Int, col: Int) -> ([Direction], Bool) {
    if row == (r - 1) && col == (c - 1) {
      return (path, true)
    } else if row == r || col == c {
      return (path, false)
    }
    if !grid[row][col] {
      return (path, false)
    }
    var rightPath = path
    rightPath.insert(Direction.Right, at: 0)
    let travelRightPath = robotGridHelper(path: rightPath, row: row, col: col + 1)
    if travelRightPath.1 {
      return travelRightPath
    }
    var downPath = path
    downPath.insert(Direction.Down, at: 0)
    let travelDownPath = robotGridHelper(path: downPath, row: row + 1, col: col)
    if travelDownPath.1 {
      return travelDownPath
    }
    return (path, false)
  }
  
  return robotGridHelper(path: [], row: 0, col: 0).0
}


// 8.3
// Given an sorted array, find magic index
// magic index is where arr[i] == i
// follow up: what if not distinct num

func findMagicIndex(arr: [Int]) -> Int {
  if arr.count == 0 {
    return -1
  }
  var foundIndex = -1
  var low = 0
  var high = arr.count - 1
  while low <= high {
    let mid = (low + high) / 2
    if arr[mid] > mid {
      high = mid - 1
    } else if arr[mid] < mid {
      low = mid + 1
    } else {
      foundIndex = mid
      break
    }
  }
  return foundIndex
}

// 8.4
// Given a set, get all subsets of it
// Implementation
func powerSet(arr: [Int]) -> [[Int]] {
  if arr.count == 0 {
    return [[]]
  }
  var subsets = arr.count == 1 ? powerSet(arr: []) : powerSet(arr: Array(arr[1..<arr.count]))
  for var i in subsets {
    i.insert(arr[0], at: 0)
    subsets.append(i)
  }
  return subsets
}

// 8.5 
// Given 2 numbers, multiply them recursively without using *. You may use add, sub, bit shifting
// Idea. First pick the bigger number to be adjusting by.
// Second. see if 2nd number - 2 >= 0, if it is, bit shift. else just leave it alone and add itself.
// Could memoize too if we really wanted, but this is fine
// didnt know we could use modulo here. myeh

func multiplyRecursively(a: Int, b: Int) -> Int {
  
  func multiplyHelper(biggerNum: Int, smallerNum :Int) -> Int {
    if smallerNum == 0 {
      return 0
    }
    var value = 0
    if smallerNum - 2 >= 0 {
      value = biggerNum << 1
      value = value + multiplyHelper(biggerNum: biggerNum, smallerNum: smallerNum - 2)
    } else {
      value = biggerNum + multiplyHelper(biggerNum: biggerNum, smallerNum: smallerNum - 1)
    }
    return value
  }
  
  let biggerNum = a > b ? a: b
  let smallerNum = biggerNum == a ? b: a
  return multiplyHelper(biggerNum: biggerNum, smallerNum: smallerNum)
}

print (multiplyRecursively(a: 26, b: 5))

// 8.6
// Towers of hannoi

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

func towersOfHannoi(n: Int) {
  var s1 = Stack<Int>.init()
  var s2 = Stack<Int>.init()
  var s3 = Stack<Int>.init()
  for index in stride(from: n, to: 1, by: -1) {
    s1.push(index)
  }
  
  func moveDisks(value: Int, destination: Stack<Int>, buffer: Stack<Int>) {
    if value > 0 {
      moveDisks(value: value - 1, destination: buffer, buffer: destination)
      var origin = s1
      let top = origin.pop()
      
      var destination = s2
      destination.push(top!)
      
    }
  }
  
  func towersOfHannoiHelper(s1: Stack<Int>, s2: Stack<Int>, s3: Stack<Int>, value: Int) {
    if value <= 0 {
      return
    }
    towersOfHannoiHelper(s1: s1, s2: s3, s3: s2, value: value - 1)
    
    var origin = s1
    let top = origin.pop()
    
    var destination = s2
    destination.push(top!)
    
    towersOfHannoiHelper(s1: s3, s2: s2, s3: s1, value: value - 1)
  }
  
  towersOfHannoiHelper(s1: s1, s2: s2, s3: s3, value: n)
}






