//
//  CSP.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/17.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

/// 约束
class Constraint<V: Hashable, D> {
    /// The variables that mark up the constraint
    var variables: [V] { [] }
    
    func isSatisfied(assignment: Dictionary<V, D>) -> Bool {
        return true
    }
}

struct CSP<V: Hashable, D> {
    let variables: [V]
    let domains: [V: [D]]
    var constraints = Dictionary<V, [Constraint<V, D>]>()
    
    init(_ variables: [V], domains: [V: [D]]) {
        self.variables = variables
        self.domains = domains
        for variable in variables {
            constraints[variable] = [Constraint]()
            if domains[variable] == nil {
                print("Error: Missing domain for variable \(variable).")
            }
        }
    }
    mutating func addConstraint(_ constraint: Constraint<V, D>) {
        for variable in constraint.variables {
            if !variables.contains(variable) {
                print("Error: Could not find variable \(variable) from constraint \(constraint) in CSP.")
            }
            constraints[variable]?.append(constraint)
        }
    }
}

func backtrackingSearch<V, D>(csp: CSP<V, D>, assignment: Dictionary<V, D> = Dictionary()) -> Dictionary<V, D>? {
    if assignment.count == csp.variables.count { return assignment }
    let unassigned  = csp.variables.lazy.filter{ assignment[$0] == nil }
    if let variable = unassigned.first, let domain = csp.domains[variable] {
        for value in domain {
            var localAssignment = assignment
            localAssignment[variable] = value
            if isConsistent(variable: variable, value: value, assignment: localAssignment, csp: csp) {
                if let result = backtrackingSearch(csp: csp, assignment: localAssignment) {
                    return result
                }
            }
        }
    }
    return nil
}

func isConsistent<V, D>(variable: V, value: D, assignment: Dictionary<V, D>, csp: CSP<V, D>) -> Bool {
    for constraint in csp.constraints[variable] ?? [] {
        if !constraint.isSatisfied(assignment: assignment) { return false }
    }
    return true
}
 
