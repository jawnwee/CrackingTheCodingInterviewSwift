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


public enum EdgeType {
  case directed, undirected
}

struct Edge<T: Hashable> {
  public var source: Vertex<T>
  public var destination: Vertex<T>
  public var weight: Double?
}

extension Edge: Hashable {
  public var hashValue: Int {
    return "\(source)\(destination)\(weight)".hashValue
  }
  
  static public func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
    return lhs.source == rhs.source &&
      lhs.destination == rhs.destination &&
      lhs.weight == rhs.weight
  }
}

struct Vertex<T: Hashable> {
  var data: T
}

extension Vertex: Hashable {
  public var hashValue: Int {
    return "\(data)".hashValue
  }
  
  static public func ==(lhs: Vertex,
                        rhs: Vertex) -> Bool {
    return lhs.data == rhs.data
  }
}

class TreeNode<T> {
  var data: T
  var leftChild: TreeNode<T>?
  var rightChild: TreeNode<T>?
  
  init(_ data: T) {
    self.data = data
  }
}

func dfs(node: TreeNode<Int>?) {
  if node == nil {
    return
  }
  print(node!.data)
  dfs(node: node?.leftChild)
  dfs(node: node?.rightChild)
}


// In graphs, should mark them as visisted
func bfs(node: TreeNode<Int>?) {
  var queue = Queue<TreeNode<Int>>()
  print(node!.data)
  if node?.leftChild != nil {
    queue.enqueue(data: (node?.leftChild)!)
  }
  if node?.rightChild != nil {
    queue.enqueue(data: (node?.rightChild)!)
  }
  while !queue.isEmpty() {
    do {
      let node = try queue.dequeue()
      
      if node.data.leftChild != nil {
        queue.enqueue(data: node.data.leftChild!)
      }
      if node.data.rightChild != nil {
        queue.enqueue(data: node.data.rightChild!)
      }

    } catch {
      print("error")
    }
  }
  
}
struct GraphNode<T> {
  var data: T
  var children: [GraphNode<T>]
  var graphState: GraphNodeState = .Unvisited
}

enum GraphNodeState {
  case Visited, Unvisited, Visiting
}

struct Graph {
  var nodes: [GraphNode<Int>]
}


// 4.1
// Given directed graph, design algorithm to find out if theres a route between two nodes
// BFS from one to the end and see if it finds the other
func routeExists(graph: Graph, firstNode: inout GraphNode<Int>, secondNode: inout GraphNode<Int>) -> Bool {
  var routeExists = false
  if firstNode.data == secondNode.data {
    return true
  }
  
  var queue = Queue<GraphNode<Int>>()
  queue.enqueue(data: firstNode)
  while !queue.isEmpty() {
    do {
      let graphNode = try queue.dequeue()
      graphNode.data.graphState = .Visiting
      if graphNode.data.data == secondNode.data {
        routeExists = true
      }
      for child in graphNode.data.children {
        if child.graphState == .Unvisited {
          queue.enqueue(data: child)
        }
      }
      graphNode.data.graphState = .Visited
    } catch {
      print("error")
    }
  }
  
  return routeExists
}

// 4.2
// Given sorted array, design a BST with minimum height
// Idea: recursively split array from middle and keep forming new treenodes
func minimumHeightBst(arr: [Int]) -> TreeNode<Int> {
  if arr.count == 1 {
    return TreeNode(arr[0])
  }
  let rootIndex = arr.count / 2
  let rootNode = TreeNode(arr[rootIndex])
  rootNode.leftChild = minimumHeightBst(arr: Array(arr[0..<rootIndex]))
  rootNode.rightChild = minimumHeightBst(arr: Array(arr[rootIndex..<arr.count]))

  return rootNode
}

// 4.3
// Given binary tree, create D linkedLists, for each level
// Idea: BFS and keep each queue per loop
// Meh put this one off because didnt want to implement linked list lol
/* class LinkedNode<T> {
  var data: T
  var next: LinkedNode<T>?
  
  init(_ data: T) {
    self.data = data
  }
}

func formLinkedLists(root: TreeNode<Int>?) -> [LinkedNode<TreeNode<Int>>] {
  if root == nil {
    return []
  }
  var listOfLinkedLists: [LinkedNode<TreeNode<Int>>] = []
  var linkedNode: LinkedNode? = LinkedNode.init(root!)
  while linkedNode!.next != nil {
    do {
      listOfLinkedLists.append(linkedNode!)
      var parents = linkedNode
      linkedNode = nil
      while parents?.next != nil {
        if linkedNode == nil {
          var graphNode = parents?.data
          linkedNode = LinkedNode.init(<#T##data: T##T#>)
        }
      }
    } catch  {
      print("error")
    }
  }

  return listOfLinkedLists
} */






