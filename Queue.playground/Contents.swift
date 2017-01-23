//: Playground - noun: a place where people can play

import UIKit

class QueueNode<T> {
  var data: T
  var next: QueueNode<T>?
  
  init(_ data: T) {
    self.data = data
  }
  
}

enum QueueError: Error {
  case Empty
}

struct Queue<T> {
  
  var first: QueueNode<T>?
  var last: QueueNode<T>?
  
  mutating func enqueue(data: T) {
    let t = QueueNode.init(data)
    if last != nil {
      last?.next = t
    }
    last = t
    if first == nil {
      first = last
    }
  }
  
  mutating func dequeue() throws -> QueueNode<T> {
    if first == nil {
      throw QueueError.Empty
    }
    let poppedNode = first
    first = first?.next
    if first == nil {
      last = nil
    }
    return poppedNode!
  }
  
  func peek() throws -> T {
    if  first == nil {
      throw QueueError.Empty
    }
    return (first?.data)!
  }
  
  func isEmpty() -> Bool {
    return first == nil
  }
  
}