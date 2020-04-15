//
//  DFS.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/14.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

func DFS<StateType: Hashable>(initialState: StateType, goalTestFn: (StateType) -> Bool, successorFn: (StateType) -> [StateType]) -> Node<StateType>? {
    var frontier = Stack<Node<StateType>>()
    frontier.push(Node(state: initialState, parent: nil))
    var explored = Set<StateType>()
    explored.insert(initialState)
    
    while !frontier.isEmpty {
        guard let currentPoint: Node<StateType> = frontier.pop() else { return nil }
        let currentState:StateType = currentPoint.state
        explored.insert(currentState)
        if goalTestFn(currentState) { return currentPoint }
        for child in successorFn(currentState) where !explored.contains(child) {
//            print(child)
            frontier.push(Node(state: child, parent: currentPoint))
        }
    }
    return nil
}
