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
  let index: Int
  
  func findNextNonEmptyLowMidHigh(low: Int, high:Int) -> (low: Int, mid: Int, high: Int) {
    var newLow = low
    var newHigh = high
    var mid = (high + low) / 2
    while arr[low] == "" && arr[mid] == "" && arr[high] == "" {
      if arr[newLow] == "" {
        newLow += 1
      }
      if arr[mid] == "" {
        mid += 1
      }
      if arr[newHigh] == "" {
        newHigh += 1
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
    }
  }
  return index
}




