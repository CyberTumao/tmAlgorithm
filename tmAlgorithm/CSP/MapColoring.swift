//
//  MapColoring.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/18.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

final class MapColoringConstraint: Constraint<String, String> {
    let place1: String
    let place2: String
    final override var variables: [String] { [place1, place2] }
    
    init(place1: String, place2: String) {
        self.place1 = place1
        self.place2 = place2
    }
    
    override func isSatisfied(assignment: Dictionary<String, String>) -> Bool {
        if assignment[place1] == nil || assignment[place2] == nil { return true }
        return assignment[place1] != assignment[place2]
    }
}
