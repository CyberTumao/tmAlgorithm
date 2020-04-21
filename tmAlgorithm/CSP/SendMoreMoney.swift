//
//  SendMoreMoney.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/21.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

final class SendMoreMoneyConstraint: Constraint<Character, Int> {
    let letters: [Character]
    final override var variables: [Character] { letters }
    
    init(letters: [Character]) {
        self.letters = letters
    }
    
    override func isSatisfied(assignment: Dictionary<Character, Int>) -> Bool {
        // if there are duplicate values then it`s not correct
        if Set<Int>(assignment.values).count < assignment.count { return false }
        if assignment.count == letters.count {
            if let s = assignment["S"], let e = assignment["E"], let n = assignment["N"], let d = assignment["D"], let m = assignment["M"], let o = assignment["O"], let r = assignment["R"], let y = assignment["Y"] {
                let send = s * 1000 + e * 100 + n * 10 + d
                let more = m * 1000 + o * 100 + r * 10 + e
                let money = m * 10000 + o * 1000 + n * 100 + e * 10 + y
                return send + more == money
            }
            return false
        }
        return true
    }
}
