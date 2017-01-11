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

print("======= 1.1 Test Cases =======")
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
  var asciiCharArray =  Array(repeating: 0, count: 256)
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

print("======= 1.2 Test Cases =======")
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

print("======= 1.3 Test Cases =======")
print(urlifyString(input: "Mr John Smith   ", stringLength: 13))

// 1.4
// Given string, check if it is a permutation of a palindrome
// Assume casing shouldn't matter, so lowercase them all
// isPermutationOfPalindrome("Tact Coa") == true
// Implementation
func isPermutationOfPalindrome(input: String) -> Bool {
  var isPermutationOfPalindrome = true
  var asciiCharArray = Array(repeating: 0, count: 256)
  var lowerCasedInputWithoutSpaces = input.lowercased().replacingOccurrences(of: " ", with: "")
  if lowerCasedInputWithoutSpaces.characters.count % 2 == 0 {
    return false
  }
  for c in lowerCasedInputWithoutSpaces.unicodeScalars {
    asciiCharArray[Int(c.value)] = asciiCharArray[Int(c.value)] + 1
  }
  
  var hasSeenMiddleCharacter = false
  for value in asciiCharArray {
    if value % 2 == 1 && !hasSeenMiddleCharacter {
      hasSeenMiddleCharacter = true
    } else if value % 2 == 1 && hasSeenMiddleCharacter {
      isPermutationOfPalindrome = false
      break
    }
  }
  return isPermutationOfPalindrome
}

print("======= 1.4 Test Cases =======")
print(isPermutationOfPalindrome(input: "Tact Coa"))
print(isPermutationOfPalindrome(input: "Tact Co"))
print(isPermutationOfPalindrome(input: "Ta"))
print(isPermutationOfPalindrome(input: "Tat"))

// 1.5
// Can be three types of edits that can be performed on strings: insert, delete, replace.
// Given two strings, write func to check if they are one edit (or zero) away
// Assume all lower case
// isOneAway("pale", "ple"), isOneAway("pales", "pale"), isOneAway("pale", "bale"), isOneAway("pale", "bake")
// Implementation
func isOneAway(first: String,
               second: String) -> Bool {
  var isOneAway = true
  if abs(first.characters.count - second.characters.count) > 1 {
    return false
  }
  var asciiCharArray = Array(repeating: 0, count: 256)
  for c in first.unicodeScalars {
    asciiCharArray[Int(c.value)] = asciiCharArray[Int(c.value)] + 1
  }
  
  for c in second.unicodeScalars {
    asciiCharArray[Int(c.value)] = asciiCharArray[Int(c.value)] - 1
  }
  
  var hasSeenOnlyOneEdit = false
  for value in asciiCharArray {
    if abs(value) == 1 && !hasSeenOnlyOneEdit {
      hasSeenOnlyOneEdit = true
    } else if abs(value) == 1 && hasSeenOnlyOneEdit {
      isOneAway = false
    }
  }
  
  return isOneAway
}

print("======= 1.5 Test Cases =======")
print(isOneAway(first: "pale", second: "ple"))
print(isOneAway(first: "pales", second: "pale"))
print(isOneAway(first: "pale", second: "bale"))
print(isOneAway(first: "pale", second: "bake"))

// 1.6
// Given string, compress it by counting number of letters and forming a new string with count next to it
// i.e "aabcccccaaa" would become "a2b1c5a3"
// if original string is shorter, return original ie "a"
// Notes:
// First solution in mind is to just loop through each character. Keeping count and resetting and appending new string
// Implementation
func compressString(input: String) -> String {
  var compressedString = ""
  var characterCount = 0
  var currentCharacter: Character = input.characters.first!
  for c in input.characters {

    if currentCharacter != c {
      compressedString.append(currentCharacter)
      compressedString += "\(characterCount)"
      characterCount = 1
      currentCharacter = c
    } else {
      characterCount += 1
    }
  }
  compressedString.append(currentCharacter)
  compressedString += "\(characterCount)"
  let resultString = input.characters.count > compressedString.characters.count ? compressedString : input
  return resultString
}

print("======= 1.6 Test Cases =======")
print(compressString(input: "aabcccccaaa"))
print(compressString(input: "a"))
print(compressString(input: "aa"))
print(compressString(input: "aabbb"))

// 1.7
// Given an NxN matrix, rotate it 90 degrees. Can you do this in place?
// Easy solution is to just create NxN array and loop through and run simple algo
// In place solution involves looping only N times and can do it in place
// Implementation

func rotateNxNMatrix(matrix: inout Array<[Int]>, dimension: Int) -> Array<Array<Int>> {
  let n = dimension
  for layer in 0..<(n / 2) {
    let first = layer
    let last = n - 1 - layer
    for i in first..<last {
      let offset = i - first
      let leftCorner = matrix[first][i]
      matrix[first][i] = matrix[last-offset][first]
      matrix[last-offset][first] = matrix[last][last-offset]
      matrix[last][last-offset] = matrix[i][last]
      matrix[i][last] = leftCorner
    }
  }
  return matrix
}

print("======= 1.7 Test Cases =======")
var matrixInput = [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13 ,14, 15]]
print(rotateNxNMatrix(matrix: &matrixInput, dimension: 4))

// 1.8
// Given MxN matrix, if an element is 0, its entire row/column are set to 0
// Implementation
func zeroMatrix(matrix: inout Array<[Int]>) -> Array<Array<Int>> {
  let numRows = matrix.count
  if numRows == 0 {
    return matrix
  }
  let numCols = matrix[0].count
  var zeroedRows = Array.init(repeating: false, count: numRows)
  var zeroedColumns = Array.init(repeating: false, count: numCols)
  for m in 0..<numRows {
    for n in 0..<numCols {
      if matrix[m][n] == 0 {
        zeroedRows[m] = true
        zeroedColumns[n] = true
      }
    }
  }
  for m in 0..<numRows {
    for n in 0..<numCols {
      if zeroedRows[m] || zeroedColumns[n] {
        matrix[m][n] = 0
      }
    }
  }
  return matrix
}

print("======= 1.8 Test Cases =======")
var matrixInput4x4 = [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13 ,14, 15]]
var matrixInput3x2 = [[0, 3], [0, 4], [1, 5], [2, 6]]
print(zeroMatrix(matrix: &matrixInput4x4))
print(zeroMatrix(matrix: &matrixInput3x2))


// 1.9
// Given two strings, s1 and s2, check if s2 is a rotation of s1 using only one call to isSubstring
// Implementation
func isRotation(first: String, second: String) -> Bool {
  let extendedString = second + second
  return extendedString.contains(first)
}
print("======= 1.0 Test Cases =======")
print(isRotation(first: "waterbottle", second: "tlewaterbot"))
print(isRotation(first: "waterbottle", second: "tlewaterbott"))
print(isRotation(first: "abbba", second: "aabbb"))


