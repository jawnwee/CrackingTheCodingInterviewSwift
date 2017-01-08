//: Playground - noun: a place where people can play

import UIKit

// 1.1
// Implement an algorithm to determin if a string has all unique characters. What if you cannot use additional data structures?
// Test Cases
// "", "abc", "aab", "a a b", "bacc", "abcdeffg"

// Implementation
func isUniqueString(input : String) -> Bool {
  var isUnique = true
  var characterSet = Set<UnicodeScalar>()
  for c in input.unicodeScalars {
    if characterSet.contains(c) {
      isUnique = false
      break
    } else {
      characterSet.insert(c)
    }
  }
  
  return isUnique
}

// Follow up answer requires a O(n^2) implementation comparing each character to the rest of string

print(isUniqueString(input: ""))
print(isUniqueString(input: "abc"))
print(isUniqueString(input: "aab"))
print(isUniqueString(input: "a b c"))
print(isUniqueString(input: "bacc"))
print(isUniqueString(input: "abcdeffg"))

// 1.2
// Given two strings, write a method to decide if one is a permutation of the other
// Important questions to ask:
// Does case sensitive matter?
// Do spaces matter?
// Assume here yes for simplicity
// Test Cases
// isPermutation("abc", "cab"), isPermutation(" c ba", "cba"), isPermutation("Cab", "abc"), isPermutation("", "ab")
// Implementation
func isPermutation(first: String,
                   second: String) -> Bool {
  var asciiCharArray =  Array(repeating: 0, count: 128)
  var isPermutation = true
  for c in first.unicodeScalars {
    asciiCharArray[Int(c.value)] = asciiCharArray[Int(c.value)] + 1
  }
  
  for c in second.unicodeScalars {
    asciiCharArray[Int(c.value)] = asciiCharArray[Int(c.value)] - 1
  }
  
  for i in asciiCharArray {
    if i != 0 {
      isPermutation = false
    }
  }
  
  return isPermutation
}

print(isPermutation(first: "abc", second: "cab"))
print(isPermutation(first: "aabbcc", second: "ccaabb"))
print(isPermutation(first: " c ba", second: "cba"))
print(isPermutation(first: "Cab", second: "abc"))
print(isPermutation(first: "", second: "cab"))

// 1.3
// Write method to replace all spaces in a string with %20.
// Assume given exact space in current string and how long string is suppsoed to be with spaces
// urlifyString("Mr John Smith    ", 13)
// Implementation
func urlifyString(input: String,
                  stringLength: Int) -> String {
  var urlifiedStringLength = stringLength
  var urlifiedString = ""
  for c in 0...stringLength - 1 {
    if input[input.index(input.startIndex, offsetBy: c)] == " " {
      urlifiedStringLength += 2
    }
  }
  for c in input.characters {
    if c == " " {
      urlifiedString += "%20"
    } else {
      urlifiedString += String(c)
    }
    if urlifiedString.characters.count == urlifiedStringLength {
      break
    }
  }
  return urlifiedString
}

print(urlifyString(input: "Mr John Smith   ", stringLength: 13))


