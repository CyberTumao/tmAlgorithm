//
//  Astar.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/14.
//  Copyright © 2020 tumao. All rights reserved.
//
//  A*算法
//

import Foundation

func astar<StateType: Hashable>(initialState: StateType, goalTestFn: (StateType) -> Bool, successorFn: (StateType) -> [StateType], heuristicFn: (StateType) -> Float) -> Node<StateType>? {
    var frontier: MinHeap<Node<StateType>> = MinHeap<Node<StateType>>()
    frontier.push(Node<StateType>(state: initialState, parent: nil, cost: 0, heuristic: heuristicFn(initialState)))
    var explored = Dictionary<StateType, Float>()
    explored[initialState] = 0
    while let currentNode = frontier.pop() {
        let currentState = currentNode.state
        if goalTestFn(currentState) {
            return currentNode
        }
        for child in successorFn(currentState) {
            let newcost = currentNode.cost + 1
            if explored[child] == nil || explored[child]! > newcost {
                explored[child] = newcost
                frontier.push(Node(state: child, parent: currentNode, cost: newcost, heuristic: heuristicFn(child)))
            }
        }
    }
    return nil
}
