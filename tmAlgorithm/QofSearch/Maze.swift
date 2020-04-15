//
//  Maze.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/14.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

enum Cell: Character {
    case Empty = "O"
    case Blocked = "X"
    case Start = "S"
    case Goal = "G"
    case Path = "P"
}

typealias Maze = [[Cell]]

struct MazeLocation: Hashable {
    let row: Int
    let col: Int
}

class Node<T>: Comparable, Hashable {
    let state: T
    let parent: Node?
    let cost: Float
    let heuristic: Float
    init(state: T, parent: Node?, cost: Float = 0, heuristic: Float = 0) {
        self.state = state
        self.parent = parent
        self.cost = cost
        self.heuristic = heuristic
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(Int(cost + heuristic))
    }
    
    static func < (lhs: Node<T>, rhs: Node<T>) -> Bool {
        lhs.cost + lhs.heuristic < rhs.cost + rhs.heuristic
    }
    
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        lhs === rhs
    }
}

func generateMaze(rows: Int, columns: Int, sparseness: Double) -> Maze {
    let maze = Maze(repeating: [Cell](repeating: .Empty, count: columns), count: rows)
    srand48(time(nil))
    return maze.map {
        $0.map {
            drand48() < sparseness ? Cell.Blocked : $0
        }
    }
}

func printMaze(_ maze: Maze) {
    for i in 0 ..< maze.count {
        print(String(maze[i].map { $0.rawValue }))
    }
}

var goal: MazeLocation = MazeLocation(row: 9, col: 9)

func goalTest(ml: MazeLocation) -> Bool {
    ml == goal
}

func heuristic(_ ml: MazeLocation) -> Float {
    let xdist = abs(ml.col - goal.col)
    let ydist = abs(ml.row - goal.row)
    return Float(xdist + ydist)
}

func successorsForMaze(_ maze: Maze) -> (MazeLocation) -> [MazeLocation] {
    func successors(ml: MazeLocation) -> [MazeLocation] {
        var newMLs = [MazeLocation]()
        if ml.col - 1 >= 0, maze[ml.row][ml.col - 1] != .Blocked {
            newMLs.append(MazeLocation(row: ml.row, col: ml.col - 1))
        }
        if ml.row - 1 >= 0, maze[ml.row - 1][ml.col] != .Blocked {
            newMLs.append(MazeLocation(row: ml.row - 1, col: ml.col))
        }
        if ml.col + 1 < maze.count, maze[ml.row][ml.col + 1] != .Blocked {
            newMLs.append(MazeLocation(row: ml.row, col: ml.col + 1))
        }
        if ml.row + 1 < maze.count, maze[ml.row + 1][ml.col] != .Blocked {
            newMLs.append(MazeLocation(row: ml.row + 1, col: ml.col))
        }
        return newMLs
    }
    return successors
}

func nodeToPath<T>(_ node: Node<T>) -> [T] {
    var path = [node.state]
    var currentNode: Node<T>? = node
    while currentNode != nil {
        path.insert(currentNode!.state, at: 0)
        currentNode = currentNode?.parent
    }
    return path
}

func markMaze(_ maze: inout Maze, path: [MazeLocation], start: MazeLocation, goal: MazeLocation) {
    for nl in path {
        maze[nl.row][nl.col] = .Path
    }
    maze[start.row][start.col] = .Start
    maze[goal.row][goal.col] = .Goal
}

func tmMazeTest() {
//    var maze = generateMaze(rows: 10, columns: 10, sparseness: 0.2)
    var maze = Maze(repeating: [Cell](repeating: .Empty, count: 5), count: 5)
    maze[3][2] = .Blocked
    maze[4][2] = .Blocked
    maze[2][4] = .Blocked
    goal = MazeLocation(row: 4, col: 4)
    let start = MazeLocation(row: 0, col: 0)
    if let solution = DFS(initialState: start, goalTestFn: goalTest, successorFn: successorsForMaze(maze)) {
        let path = nodeToPath(solution)
        var maze_p = maze
        markMaze(&maze_p, path: path, start: start, goal: goal)
        print("DFS:")
        printMaze(maze_p)
    } else {
        print("Can not reach the goal")
    }
    if let solution = BFS(initialState: start, goalTestFn: goalTest, successorFn: successorsForMaze(maze)) {
        let path = nodeToPath(solution)
        var maze_p = maze
        markMaze(&maze_p, path: path, start: start, goal: goal)
        print("BFS:")
        printMaze(maze_p)
    } else {
        print("Can not reach the goal")
    }
    if let solution = astar(initialState: start, goalTestFn: goalTest, successorFn: successorsForMaze(maze), heuristicFn: heuristic) {
        let path = nodeToPath(solution)
        markMaze(&maze, path: path, start: start, goal: goal)
        print("A*:")
        printMaze(maze)
    } else {
        print("Can not reach the goal")
    }
}
