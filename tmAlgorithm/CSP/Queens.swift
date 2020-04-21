//
//  Queens.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/20.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

final class QueensConstraint: Constraint<Int, Int> {
    let columns: [Int]
    final override var variables: [Int] { columns }
    
    init(columns: [Int]) {
        self.columns = columns
    }
    
    override func isSatisfied(assignment: Dictionary<Int, Int>) -> Bool {
        for (q1r, q1c) in assignment {
            if (q1r >= variables.count) {
//            if (q1r <= 1) {
                continue
            }
            for q2r in (q1r + 1) ... variables.count {
//            for q2r in 1 ... q1r - 1 {
                if let q2c = assignment[q2r] {
                    if q1c == q2c { return false }
                    if abs(q1c - q2c) == abs(q1r - q2r) { return false }
                }
            }
        }
        return true
    }
}
