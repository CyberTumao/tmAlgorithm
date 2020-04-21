//
//  CircuitBoard.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/21.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

typealias CBGrid = [[Int]]

struct CBGridLocation: Hashable {
    let row: Int
    let col: Int
}

final class CircuitBoardConstraint: Constraint<String, [CBGridLocation]> {
    let boards: [String]
    final override var variables: [String] { boards }
    
    init(boards: [String]) {
        self.boards = boards
    }
    
    override func isSatisfied(assignment: Dictionary<String, [CBGridLocation]>) -> Bool {
        Set<CBGridLocation>(assignment.values.flatMap( { $0 } )).count == assignment.values.flatMap( { $0 } ).count
    }
}
