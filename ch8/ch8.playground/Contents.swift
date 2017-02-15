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
// hard problem myeh.

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

// 8.7
// Permutations without dups. Write a method to get all permutations of a a string with unique characters
// Naive solution is to start from 1 character. and for each of the remaining characters. find permutations of those
// recursivley :(

func calculatePermutations(string: String) -> [String] {
  if string.characters.count == 1 {
    return [string]
  }
  var resultPermutations = [String]()
  for i in string.characters {
    let charString = String(i)
    let remainingLetters = string.replacingOccurrences(of: String(i), with:"")
    let permutationsOfRemaining = calculatePermutations(string: remainingLetters)
    for permutation in permutationsOfRemaining {
      let resultString = charString + permutation
      resultPermutations.append(resultString)
    }
  }
  return resultPermutations
}

// 8.8
// Permutation with dupes.
// Naive way was to do same as above and just not add duplicates
// Better way is to keep count of all letters. Then recursively pass down map with less count of the character
// Implementation

func permutationWithDupes(string: String){
  var result = [String]()
  let map = freqMap(string: string)
  printPerms(map: map, prefix: "", remaining: string.characters.count, result: &result)
}

func printPerms(map: [String : Int], prefix: String, remaining: Int, result: inout [String]) {
  if remaining == 0 {
    result.append(prefix)
    return
  }
  var currentMap = map
  for c in map.keys {
    let count = map[c]
    if count! > 0 {
      currentMap[c]! -= 1
      printPerms(map: currentMap, prefix: prefix + c, remaining: remaining - 1, result: &result)
      currentMap[c]! = count!
    }
  }
}

func freqMap(string: String) -> [String : Int] {
  var map = [String : Int]()
  for c in string.characters {
    let charString = String(c)
    if map[charString] == nil {
      map[charString] = 1
    } else {
      map[charString]! += 1
    }
  }
  return map
}

// 8.9
// Given an input n, print out all valid properly open and closed combination of parenthesis
// input 2: -> ()(), (())
// Idea: use left and right paren and count

func addParen(list: inout [String], leftRemaining: Int, rightRemaining: Int, string: inout [Character], index: Int) {
  if leftRemaining < 0 || rightRemaining < leftRemaining {
    return
  }
  if leftRemaining == 0 && rightRemaining == 0 {
    list.append(String(string))
  } else {
    string[index] = "("
    addParen(list: &list, leftRemaining: leftRemaining - 1, rightRemaining: rightRemaining, string: &string, index: index + 1)
    
    string[index] = ")"
    addParen(list: &list, leftRemaining: leftRemaining, rightRemaining: rightRemaining - 1, string: &string, index: index + 1)
  }
}

func generateParens(n: Int) -> [String] {
  var parenList = [String]()
  var charList = Array(repeating: Character(""), count: n * 2)
  addParen(list: &parenList, leftRemaining: n, rightRemaining: n, string: &charList, index: 0)
  return parenList
}


// 8.10
// Given a screen, paint fill with a color, given a point.
// Idea: use recursion, but make sure to keep track of visited points

enum Color {
  case White
  case Black
  case Blue
}

func paintFill(screen: [[Color]], row: Int, col: Int, newColor: Color) {
  var currentScreen = screen
  let colorToChange = screen[row][col]
  let rowMaxBound = screen.count
  let colMaxBound = screen[0].count
  var visitedMatrix = Array<Array<Bool>>()
  for column in 0...colMaxBound {
    visitedMatrix.append(Array(repeating:false, count:rowMaxBound))
  }
  func paintFillHelper(screen: inout [[Color]], row: Int, col: Int) {
    if row < 0 || row >= rowMaxBound {
      return
    } else if col < 0 || col >= colMaxBound {
      return
    } else if visitedMatrix[row][col] == true {
      return
    }
    visitedMatrix[row][col] = true
    if screen[row][col] == colorToChange {
      screen[row][col] = newColor
    }
    paintFillHelper(screen: &screen, row: row - 1, col: col)
    paintFillHelper(screen: &screen, row: row + 1, col: col)
    paintFillHelper(screen: &screen, row: row, col: col + 1)
    paintFillHelper(screen: &screen, row: row, col: col - 1)
  }
  paintFillHelper(screen: &currentScreen, row: row, col: col)
}

// 10.11
// Given infinite number of coins, write code to calculate number of ways representing n cents
// Idea is to recursively go through and memoize

func coins(n : Int) -> Int {
  var memoizeMap = [String: Int]()
  func coinsCounter(n: Int) -> Int {
    if n == 0 {
      return 1
    } else if n < 0 {
      return 0
    }
    var useQuarter = 0
    var useDime = 0
    var useNickel = 0
    var usePenny = 0
    
    let subQuarter = n - 25
    if memoizeMap[String(subQuarter)] == nil {
      useQuarter = coinsCounter(n: subQuarter)
      memoizeMap[String(subQuarter)] = useQuarter
    } else {
      useQuarter = memoizeMap[String(subQuarter)]!
    }
    
    let subDime = n - 10
    if memoizeMap[String(subDime)] == nil {
      useDime = coinsCounter(n: subDime)
      memoizeMap[String(subDime)] = useDime
    } else {
      useDime = memoizeMap[String(subDime)]!
    }
    
    let subNickel = n - 5
    if memoizeMap[String(subNickel)] == nil {
      useNickel = coinsCounter(n: subNickel)
      memoizeMap[String(subNickel)] = useNickel
    } else {
      useNickel = memoizeMap[String(subNickel)]!
    }
    
    let subPenny = n - 1
    if memoizeMap[String(subPenny)] == nil {
      usePenny = coinsCounter(n: subQuarter)
      memoizeMap[String(subPenny)] = usePenny
    } else {
      usePenny = memoizeMap[String(subPenny)]!
    }

    return useQuarter + useDime + useNickel + usePenny
  }
  return coinsCounter(n: n)
}




