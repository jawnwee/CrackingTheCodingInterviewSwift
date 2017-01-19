//: Playground - noun: a place where people can play

import UIKit

class Node<T> : NSObject {
  
  var value: T
  var next: Node?
  
  public init(value: T) {
    self.value = value
  }
  
}

// 2.1
// Remove duplicates from an unsorted linked list. How about without a temporary buffer?
// Ideas
// Store values in set. Check next's value and point the .next to the next.next.
// The one without temporary buffer runs in O(n^2)
// Implementation
func removeDupes(headNode: Node<Int>){
  var set: Set = Set<Int>()
  var tempHead = headNode
  set.insert(tempHead.value)
  while (tempHead.next != nil) {
    if !set.contains(tempHead.next!.value) {
      set.insert(tempHead.next!.value)
    } else {
      if tempHead.next?.next != nil {
        tempHead.next = tempHead.next?.next
      }
    }
    tempHead = tempHead.next!
  }
}

var node1 = Node.init(value: 1)
let node2 = Node.init(value: 2)
let node3 = Node.init(value: 1)
let node4 = Node.init(value: 4)
let node5 = Node.init(value: 5)
let node6 = Node.init(value: 2)
let node7 = Node.init(value: 7)
node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
node5.next = node6
node6.next = node7
removeDupes(headNode: node1)
while node1.next != nil {
  print(node1.value)
  node1 = node1.next!
}
print(node1.value)

// 2.2
// Find the kth to last element of a singly linked list
// Idea
// Have 2 Linked List. Move one k times
// Then move both at same time till the first moved one reaches end.
// Implementation
func kthToLast(node: Node<Int>, k: Int) -> Int {
  var kAheadNode = node
  var tempNode = node
  for _ in 0..<k {
    if kAheadNode.next == nil {
      break;
    } else {
      kAheadNode = kAheadNode.next!
    }
  }
  while kAheadNode.next != nil {
    tempNode = tempNode.next!
    kAheadNode = kAheadNode.next!
  }
  return tempNode.value
}

// 2.3
// Given a middle node, delete it
// Any node but first and last
// Implementation
func deleteMiddleNode(node: Node<Int>) {
  let repointedNode = node
  repointedNode.value = (repointedNode.next?.value)!
  repointedNode.next = repointedNode.next?.next
}

// 2.4
// Write code to partition linked list around a value x
// Idea is to keept a left and right and merge the two after
// Implementation
func partitionLinkedList(headNode: Node<Int>, partition: Int) {
  var leftNode: Node<Int>?
  var rightNode: Node<Int>?
  while headNode.next != nil {
    if headNode.value < partition {
      if leftNode == nil {
        leftNode = Node(value: headNode.value)
      } else {
        let newNode = Node(value: headNode.value)
        newNode.next = leftNode
        leftNode = newNode
      }
    } else {
      if rightNode == nil {
        rightNode = Node(value: headNode.value)
      } else {
        let newNode = Node(value: headNode.value)
        newNode.next = rightNode
        rightNode = newNode
      }
    }
  }
  while leftNode?.next != nil {
    leftNode = leftNode?.next
  }
  leftNode?.next = rightNode
}

// 2.5
// Given 2 numbers represented by a linkedlist (stored in reversed order), add them up and return them as linkedlist
// Idea is to multiply to extract and divide to make into linked list
// Problem is returning list in proper order of 9 -> 1 -> 2 for 912. If we want it reversed, just assume a headNode reference exists
// Implementation
func sumLinkedLists(first: Node<Int>,
                    second: Node<Int>) -> Node<Int> {
  let firstNumber = sumLinkedListHelper(node: first)
  let secondNumber = sumLinkedListHelper(node: second)
  var summedNumber = firstNumber + secondNumber
  var headNode: Node<Int>?
  while summedNumber % 10 > 0 {
    let digit = summedNumber % 10
    summedNumber = summedNumber / 10
    if headNode == nil {
      headNode = Node.init(value: digit)
    } else {
      let newHeadNode = Node.init(value: digit)
      newHeadNode.next = headNode
      headNode = newHeadNode
    }
  }
  return headNode!
}

func sumLinkedListHelper(node: Node<Int>) -> Int {
  var sum = 0
  var multiplier = 1
  while node.next != nil {
    sum += multiplier * node.value
    multiplier *= 10
  }
  return sum
}

// 2.6
// Given a linked list, check if the list is a palindrome
// Idea is to recreate the linkedlist, but reverse it. Then check the two are equal
// Implementation
func isPalindrome(head: Node<Int>) -> Bool {
  var isPalindrome = true
  var reversedList = head
  reversedList.next = nil
  var currentHead = head
  var tempHead = head
  while tempHead.next != nil {
    let newReversedListHead = Node.init(value: tempHead.value)
    newReversedListHead.next = reversedList
    reversedList = newReversedListHead
    tempHead = tempHead.next!
  }
  
  while currentHead.next != nil {
    if reversedList.value != currentHead.value {
      isPalindrome = false
      break
    }
    reversedList = reversedList.next!
    currentHead = currentHead.next!
  }
  
  return isPalindrome
}

// 2.7
// Given 2 singly linked lists, determine if intersect
// The part that I missed was the fact that intersection means the last node is the same
// Implementation
func intersectingNode(first: Node<Int>, second: Node<Int>) -> Node<Int> {
  var firstCount = 0
  var secondCount = 0
  var tempFirst: Node? = first
  var tempSecond: Node? = second
  if tempFirst != nil {
    firstCount = 1
  }
  if tempSecond != nil {
    secondCount = 1
  }
  while tempFirst?.next != nil {
    tempFirst = tempFirst?.next!
    firstCount += 1
  }
  while tempSecond?.next != nil {
    tempSecond = tempSecond?.next!
    secondCount += 1
  }
  
  let isFirstLongerThanSecond = firstCount > secondCount ? true : false
  let difference = abs(firstCount - secondCount)
  
  var startNode = isFirstLongerThanSecond == true ? first : second
  
  for _ in 0..<difference {
    startNode = startNode.next!
  }
  var otherNode = isFirstLongerThanSecond == true ? second : first
  var intersectNode: Node<Int>?
  while otherNode.next != nil {
    if otherNode == startNode {
      intersectNode = otherNode
      break
    }
    otherNode = otherNode.next!
    startNode = startNode.next!
  }
  
  return intersectNode!
}

// 2.8
// Given circular linked list, implement algo to find node that begins the loop
// Implementation
func findBeginningOfLoop(headNode: Node<Int>) -> Node<Int> {
  var slowNode = headNode
  var fastNode = headNode
  while slowNode != fastNode {
    slowNode = slowNode.next!
    fastNode = (fastNode.next?.next)!
  }
  var node = headNode
  while slowNode != node {
    slowNode = slowNode.next!
    node = node.next!
  }
  
  return node
}

