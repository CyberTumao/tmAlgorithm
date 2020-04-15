//
//  MaxHeap.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/14.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

/*
 //测试
 var maxHeap: MaxHeap<Int> = MaxHeap()
 maxHeap.initHeapWithArray([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
 print(maxHeap)
 maxHeap.pop()
 print(maxHeap)
 */
struct MaxHeap<T: Comparable>: Heap {
    typealias Element = T
    
    internal var container: [T]?
    
    init() {}
    mutating func push(_ value: T) {
        if container == nil {
            container = [T]()
        }
        container?.append(value)
        var count = container?.count ?? 1
        while count >> 1 > 0 {
            let father = container![count >> 1 - 1]
            if father < value {
                exchange(&(container)!, first: count - 1, second: count >> 1 - 1)
                count >>= 1
            } else {
                return
            }
        }
    }
    mutating func pop() -> T? {
        if container == nil || container!.count == 0 {
            return nil
        }
        var count = container!.count
        if count > 1 {
            exchange(&(container)!, first: 0, second: count - 1)
        }
        defer {
            var sub = 1
            count = container!.count
            while sub << 1 <= count - 1 {
                if container![sub << 1 - 1] >= container![sub -  1] {
                    if container![sub << 1] > container![sub << 1 - 1] {
                        exchange(&(container)!, first: sub - 1, second: sub << 1)
                        sub = sub << 1 + 1
                    } else {
                        exchange(&(container)!, first: sub - 1, second: sub << 1 - 1)
                        sub = sub << 1
                    }
                } else if container![sub << 1] >= container![sub - 1] {
                    exchange(&(container)!, first: sub - 1, second: sub << 1)
                    sub = sub << 1 + 1
                }
            }
        }
        return container?.removeLast()
    }
}
