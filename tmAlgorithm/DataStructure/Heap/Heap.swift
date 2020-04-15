//
//  Heap.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/14.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

protocol Heap: CustomStringConvertible {
    associatedtype Element: Comparable
    
    var container: [Element]? { get set }
    
    init()
    mutating func push(_ value:Element)
    mutating func pop() -> Element?
}

extension Heap {
    var description: String {
        guard let heap = container else {
            return "Heap is nil"
        }
        return "\(heap)"
    }
    mutating func initHeapWithArray(_ array: [Element]?) {
        if array == nil {
            return
        }
        if container == nil {
            container = [Element]()
        } else {
            container?.removeAll()
        }
        for item in array! {
            push(item)
        }
    }
    func exchange(_ array: inout [Element], first: Int, second: Int) {
        guard first < array.count, second < array.count else { return }
        let value = array[first]
        array[first] = array[second]
        array[second] = value
    }
}

