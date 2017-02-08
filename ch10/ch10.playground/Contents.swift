//: Playground - noun: a place where people can play

import UIKit

// 10.1
// Given 2 sorted lists, merge B into A

func mergeList(arrA: [Int], arrB: [Int]) -> [Int] {
  var indexA = 0
  var indexB = 0
  var mergedList = [Int]()
  while indexA < arrA.count && indexB < arrB.count {
    if arrA[indexA] >= arrB[indexB] {
      mergedList.append(arrA[indexA])
      indexA += 1
    } else {
      mergedList.append(arrB[indexB])
      indexB += 1
    }
  }
  return mergedList
}

// 10.2
// Sort an array of strings so that all the anagrams are next to each other

func sortForAnagrams(arr: [String]) -> [String] {
  var groupedAnagrams = [String]()
  var hashMap = [String: [String]]()
  for str in arr {
    let sortedStr = String(str.characters.sorted())
    hashMap[sortedStr]?.append(str)
  }
  
  for key in hashMap.keys {
    for str in hashMap[key]! {
      groupedAnagrams.append(str)
    }
  }
  return groupedAnagrams
}

// 10.3
// Given sorted array that was rotated unknown number of times, find index of n
// Idea
// Recursively look at beggining, middle, end, see where it should lie.

func findInRotatedArray(arr: [Int], value: Int) -> Int {
  if arr.count == 0 {
    return -1
  }
  return findInRotatedArrayHelper(arr: arr, value: value, begin: 0, mid: arr.count / 2, end: arr.count - 1)
}

func findInRotatedArrayHelper(arr: [Int], value: Int, begin: Int, mid: Int, end: Int) -> Int {
  if begin == mid && mid == end {
    return -1
  }
  if arr[begin] == value {
    return begin
  } else if arr[mid] == value {
    return mid
  } else if arr[end] == value {
    return end
  } else {
    if (value < arr[mid] && value > arr[begin]) || (value < arr[mid] && value < arr[begin]) {
      return findInRotatedArrayHelper(arr: arr, value: value, begin: begin, mid: (begin + end) / 2, end: mid)
    } else {
      return findInRotatedArrayHelper(arr: arr, value: value, begin: mid, mid: mid + mid / 2, end: end)
    }
  }
}
print("============10.3 Testing============")
print(findInRotatedArray(arr: [15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14], value: 5))
print(findInRotatedArray(arr: [], value: 5))
print(findInRotatedArray(arr: [10, 15, 20, 0, 5], value: 0))
print(findInRotatedArray(arr: [10, 15, 20, 0, 5], value: 15))
print(findInRotatedArray(arr: [50, 5, 20, 30, 40], value: 5))

// 10.4
// Given an array data structure, Listy, which doesnt have a size method, find the index
// that has x in it. If there is no element, its contains -1. Listy only has positive numbers
// Idea is to use exponential backoff and stop when -1 is found. In this case I made some simplistic assumptions
// Implementation. If found multiple, return any index
func sortedSearch(listy: [Int], value: Int) -> Int {
  var multiplier = 1
  // For the purpose of simplicity, lets assume .count method is the same as checking for the value -1
  while listy.count > multiplier {
    if listy[multiplier] == value {
      return multiplier
    }
    if listy[multiplier] < value {
      break
    }
    multiplier *= 2
  }
  let index = binarySearch(listy: listy, value: value, endIndex: multiplier)
  
  return index
}

func binarySearch(listy: [Int], value: Int, endIndex: Int) -> Int {
  var left = 0
  var right = endIndex
  var foundIndex = -1
  while left <= right {
    let mid = (right + left) / 2
    if listy[mid] > value {
      right = mid - 1
    } else if value > listy[mid] {
      left = mid + 1
    } else {
      foundIndex = mid
    }
  }
  return foundIndex
}

// 10.5
func sparseSearch(string: String, arr: [String]) -> Int {
  var low = 0
  var high = arr.count - 1
  var index: Int = -1
  
  func findNextNonEmptyLowMidHigh(low: Int, high:Int) -> (low: Int, mid: Int, high: Int) {
    var newLow = low
    var newHigh = high
    var mid = (high + low) / 2
    while arr[newLow] == "" || arr[mid] == "" || arr[newHigh] == "" {
      if arr[newLow] == "" {
        newLow += 1
      }
      if arr[mid] == "" {
        mid -= 1
      }
      if arr[newHigh] == "" {
        newHigh -= 1
      }
    }
    return (newLow, mid, newHigh)
  }
  
  while low <= high {
    let adjustedIndices = findNextNonEmptyLowMidHigh(low: low, high: high)
    if string.compare(arr[adjustedIndices.mid]).rawValue < 0 {
      high = adjustedIndices.mid - 1
    } else if string.compare(arr[adjustedIndices.mid]).rawValue > 0 {
      low = adjustedIndices.mid + 1
    } else {
      index = adjustedIndices.mid
      break
    }
  }
  return index
}

print(sparseSearch(string: "ball", arr: ["at", "", "", "", "ball", "", "", "car", "", "", "dad", "", ""]))

// 10.6
// Uhh skip this lol

// 10.7 and 10.8 were asking for bit stuff. Somewhat interesting I guess

// 10.9
// Given MxN matrix, sorted in asc order in both row and col. find value

func findValue(matrix: [[Int]], val:Int) -> (Int, Int) {
  var found = (-1, -1)
  if matrix.count == 0 {
    return found
  }
  let mCount = matrix.count
  let nCount = matrix[0].count
  var elementCount = mCount * nCount
  var lowIndex = (0, 0)
  var highIndex = (mCount - 1, nCount - 1)
  while lowIndex.0 <= highIndex.0 && lowIndex.1 <= highIndex.1 {
    elementCount /= 2
    let mid = matrixPointHelper(original: lowIndex, moveBy: elementCount, maxM: mCount, maxN: nCount)
    if (matrix[mid.0][mid.1] > val) {
      highIndex = matrixPointHelper(original: mid, moveBy: -1, maxM: mCount, maxN: nCount)
    } else if (matrix[mid.0][mid.1] < val) {
      lowIndex = matrixPointHelper(original: mid, moveBy: 1, maxM: mCount, maxN: nCount)
    } else {
      found = mid
      break
    }
  }
  return found
}

func matrixPointHelper(original:(Int, Int), moveBy: Int, maxM: Int, maxN: Int) -> (Int, Int) {
  let adjustedN = original.1 + moveBy
  var movedPoint = (original.0, adjustedN)
  if adjustedN > maxN {
    let rowAdjustment = adjustedN / maxM
    let colAdjustment = adjustedN % maxM
    movedPoint = (rowAdjustment, colAdjustment)
  } else if adjustedN < 0 {
    var additionalRowShift = 0
    if abs(adjustedN) > maxM {
      additionalRowShift = abs(adjustedN) / maxM
    }
    let rowAdjustment = 1 + additionalRowShift
    let colAdjustment = abs(adjustedN + maxN) % maxM
    movedPoint = (original.0 - rowAdjustment, colAdjustment)
  }
  return movedPoint
}

// Ugh Improvements that couldve been made to this solution
// Only really needed to work down diagonally from top right corner.., didnt actually have to do the middle
// However, to even further do the expansion. The solution works by finding which quadrant to recurse through because you can tell
// from the corners of the middle.

// 10.10
// Given a stream of numbers, implement data structure to properly track each number, and get rank
// rank is count of all elements <= x
// Idea is to have a linkedlist with a rank attached to them and also a hashmap with current rank for lookup
// Track is O(n), but look up is O(1)
// Book says to use a BST so that insert and look up are O(logN), but if tree is unbalanced, lookup will be O(N). Tradeoffs.


// 10.11
// Given array of integers, sort into alternating seq of peak and valley
// peak is when num is > its adj number and valley is the opposite
// Idea: sort array and start from both ends and alternate each one until the middle/no more
// O(nlogn)
func sortArray(arr: [Int], start: Int, end: Int) -> [Int] {
  if start == end {
    return [arr[start]]
  }
  let mid = (start + end) / 2
  var leftIndex = 0
  var rightIndex = 0
  let leftSorted = sortArray(arr: arr, start: start, end: mid)
  let rightSorted = sortArray(arr: arr, start: mid + 1, end: end)
  var sortedArray = [Int]()
  while leftIndex != leftSorted.count || rightIndex != rightSorted.count {
    if leftIndex != leftSorted.count && rightIndex != rightSorted.count {
      if leftSorted[leftIndex] <= rightSorted[rightIndex] {
        sortedArray.append(leftSorted[leftIndex])
        leftIndex += 1
      } else {
        sortedArray.append(rightSorted[rightIndex])
        rightIndex += 1
      }
    } else if leftIndex == leftSorted.count {
      sortedArray.append(rightSorted[rightIndex])
      rightIndex += 1
    } else {
      sortedArray.append(leftSorted[leftIndex])
      leftIndex += 1
    }
  }
  return sortedArray
}

func sortToPeaksAndValley(arr: [Int]) -> [Int] {
  let sortedArray: [Int] = sortArray(arr: arr, start: 0, end: (arr.count - 1))
  let lastIndex = sortedArray.count - 1
  var index = 0
  var sortedToPeaksAndValley = [Int]()
  while index != (lastIndex - index) {
    sortedToPeaksAndValley.append(sortedArray[lastIndex - index])
    sortedToPeaksAndValley.append(sortedArray[index])
    index += 1
  }
  if sortedArray.count % 2 == 1 {
    sortedToPeaksAndValley.append(sortedArray[index])
  }
  return sortedToPeaksAndValley
}

print(sortToPeaksAndValley(arr: [5,3,1,2,3]))
print(sortToPeaksAndValley(arr: [5, 8, 6, 2, 3, 4, 6]))

// Improved solution involves just shifting the window
func sortValleyPeakImproved(arr: inout [Int]) -> [Int] {
  for i in stride(from: 1, to: arr.count, by: 2) {
    let biggestIndex = maxIndex(arr: arr, a: i-1, b: i, c: i+1)
    if i != biggestIndex {
      swap(arr: &arr, left: i, right: biggestIndex)
    }
  }
  return arr
}

func swap(arr: inout [Int], left: Int, right: Int) {
  let temp = arr[left]
  arr[left] = arr[right]
  arr[right] = temp
}

func maxIndex(arr: [Int], a: Int, b: Int, c: Int) -> Int {
  let len = arr.count
  let aValue = a >= 0 && a < len ? arr[a] : nil
  let bValue = b >= 0 && b < len ? arr[b] : nil
  let cValue = c >= 0 && c < len ? arr[c] : nil
  let values: [Int] = [aValue!, bValue!, cValue!]
  let max = values.max()
  if aValue == max {
    return a
  } else if bValue == max {
    return b
  } else {
    return c
  }
}
