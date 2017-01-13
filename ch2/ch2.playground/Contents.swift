//: Playground - noun: a place where people can play

import UIKit

class Node<T> {
  
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
