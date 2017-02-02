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
  var parent: TreeNode<T>?
  
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

// 4.4
// Given binary tree, determine if its balanced aka height the two subtrees of ANY node may never differ
// by more than one
// Idea: return -1 if heights are different by more than 1
func isBalancedBst(treeNode: TreeNode<Int>) -> Bool {
  return balanceBstHelper(treeNode: treeNode) != -1
}

func balanceBstHelper(treeNode: TreeNode<Int>?) -> Int {
  if treeNode == nil {
    return 0
  }
  
  let leftHeight = balanceBstHelper(treeNode: treeNode!.leftChild)
  let rightHeight = balanceBstHelper(treeNode: treeNode!.rightChild)
  if rightHeight == -1 || leftHeight == -1 {
    return -1
  }
  let difference = abs(leftHeight - rightHeight)
  if difference > 1 {
    return -1
  }
  return max(leftHeight, rightHeight)
}

// 4.5
// Given binary tree, validate if it is a BST

func isBst(treeNode: TreeNode<Int>?) -> Bool {
  let leftSideMax = findMax(treeNode: treeNode!.leftChild)
  let rightSideMax = findMin(treeNode: treeNode!.rightChild)
  return leftSideMax < (treeNode?.data)! && rightSideMax > (treeNode?.data)!
}

func findMax(treeNode: TreeNode<Int>?) -> Int {
  if treeNode!.leftChild == nil && treeNode!.rightChild == nil {
    return treeNode!.data
  }
  
  if ((treeNode?.leftChild) != nil) && treeNode!.rightChild == nil {
    max(treeNode!.data, findMax(treeNode: treeNode?.leftChild))
  }
  
  if ((treeNode?.rightChild) != nil) && treeNode!.leftChild == nil {
    max(treeNode!.data, findMax(treeNode: treeNode?.rightChild))
  }
  
  return max(findMax(treeNode: treeNode?.leftChild), findMax(treeNode: treeNode?.rightChild))
}

func findMin(treeNode: TreeNode<Int>?) -> Int {
  if treeNode!.leftChild == nil && treeNode!.rightChild == nil {
    return treeNode!.data
  }
  
  
  if ((treeNode?.leftChild) != nil) && treeNode!.rightChild == nil {
    min(treeNode!.data, findMax(treeNode: treeNode?.leftChild))
  }
  
  if ((treeNode?.rightChild) != nil) && treeNode!.leftChild == nil {
    min(treeNode!.data, findMax(treeNode: treeNode?.rightChild))
  }
  
  return min(findMax(treeNode: treeNode?.leftChild), findMax(treeNode: treeNode?.rightChild))
}


// 4.6
// Given tree node, find the "next" node. Assume you have link to parent
// Idea is to check what kind of node it is
// Left means its parent and its .left the same and no left/right child
// Root means it could have right or left
// Right means its parent and its .right are the same and no left/right child
// Assume passing in non nil node

func nextNode(node: TreeNode<Int>) -> TreeNode<Int>? {
  let isRootNode = checkIsRootNode(node)
  let isLeftNode = checkIsLeftNode(node)
  let nextNode: TreeNode<Int>?
  if isLeftNode {
    nextNode = node.parent!
  } else if isRootNode {
    if node.rightChild != nil {
      nextNode = findLeftMostNode(node: node.rightChild!)
    } else {
      nextNode = findRootNode(node: node).0
    }
  } else {
    let rootNodeTuple = findRootNode(node: node)
    if rootNodeTuple.1 {
      nextNode = rootNodeTuple.0
    } else {
      nextNode = nil
    }
  }
  return nextNode
}

func checkIsRootNode(_ node: TreeNode<Int>) -> Bool {
  return node.leftChild != nil || node.rightChild != nil
}

func checkIsLeftNode(_ node: TreeNode<Int>) -> Bool {
  return node.parent?.leftChild === node && node.leftChild == nil && node.rightChild == nil
}

func findLeftMostNode(node: TreeNode<Int>) -> TreeNode<Int> {
  if node.leftChild == nil {
    return node
  }
  return findLeftMostNode(node: node.leftChild!)
}

func findRootNode(node: TreeNode<Int>) -> (TreeNode<Int>, Bool) {
  if node.parent?.parent == nil {
    let isLeftNode = node.parent?.leftChild === node
    return (node.parent!, isLeftNode)
  }
  return findRootNode(node: node.parent!)
}

// 4.7
// Given list of projects and list of dependencies (a tuple of (p1, p2) where p2 depends on p1 being built first)
// Find a build order that allows the projects to be built
// Left this one uncoded was just too lazy to make the graph
// 1) Create graph and a hashmap of dependencies
// 2) Keep a stack of built projects and check and remove from graph/hashmap and put in stack the nodes
// 3) Iterate through stack and repeat
// 4) If Stack isnt empty, return error, else succeeded with build


// 4.8
// First common ancestor of two nodes in a binary tree
// Idea is to use post order traversal
// Implementation
func firstCommonAncestor(node: TreeNode<Int>?,
                         n1: TreeNode<Int>,
                         n2: TreeNode<Int>) -> TreeNode<Int>? {
  if node == nil {
    return nil
  }
  let leftSubTreeFoundAncestor = firstCommonAncestor(node: node?.leftChild, n1: n1, n2: n2)
  let rightSubTreeFoundAncestor = firstCommonAncestor(node: node?.rightChild, n1: n1, n2: n2)
  if leftSubTreeFoundAncestor != nil  && rightSubTreeFoundAncestor != nil {
    return node
  }
  let isNodePartOfSearch = node === n1 || node === n2
  if isNodePartOfSearch && (leftSubTreeFoundAncestor == nil || rightSubTreeFoundAncestor == nil) {
    return node
  } else {
    if leftSubTreeFoundAncestor != nil {
      return leftSubTreeFoundAncestor
    } else if rightSubTreeFoundAncestor != nil {
      return rightSubTreeFoundAncestor
    } else {
      return nil
    }
  }
  
}

// 4.9
// A Bst gets build from an array, build all possible arrays
// Idea:
// 1) root (left) (right)
// 2) root (right) (left)
// 3) root left.data (right) (left)
// 4) root left.data (left) (right)
// 5) root right.data (right) (left)
// 6) root right.data (left) (right)

// 4.10
// Given 2 large trees, check if t2 is in t1
// Use pre order and put nulls at every empty node
// check substring of another

// 4.11
// Implement binary tree class to insert, find, delete, and getRandomNode
// Implement getRandomNode
// Pick random number 0-N
// keep track of size of left and right tree and if number is equal to
// selected one, pick that one

// 4.12
// Given binary tree, return number of paths that let sum up to a value
// can be any path start -> some middle value











