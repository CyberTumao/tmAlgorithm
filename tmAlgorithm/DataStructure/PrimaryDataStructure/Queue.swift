//
//  Queue.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/14.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

struct Queue<T: Comparable>: CustomStringConvertible {
    private var container: [T]?
    var isEmpty: Bool { container?.isEmpty ?? false }
    mutating func push(_ value: T) {
        if container == nil {
            container = [T]()
        }
        container?.append(value)
    }
    mutating func pop() -> T? {
        container?.removeFirst()
    }
    var description: String { container?.description ?? "Void Queue!" }
}
