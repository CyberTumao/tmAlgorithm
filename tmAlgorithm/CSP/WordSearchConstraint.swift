//
//  WordSearchConstraint.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/21.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

typealias Grid = [[Character]]

struct GridLocation: Hashable {
    let row: Int
    let col: Int
}

final class WordSearchConstraint: Constraint<String, [GridLocation]> {
    let words: [String]
    final override var variables: [String] { words }

    init(words: [String]) {
        self.words = words
    }
    
    override func isSatisfied(assignment: Dictionary<String, [GridLocation]>) -> Bool {
        Set<GridLocation>(assignment.values.flatMap( { $0 } )).count >= assignment.values.flatMap( { $0 } ).count
    }
}
