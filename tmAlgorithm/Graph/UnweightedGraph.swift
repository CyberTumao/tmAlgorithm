//
//  UnweightedGraph.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/22.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class UnweightedEdge: Edge {
    var u: Int
    var v: Int
    var reserved: Edge { UnweightedEdge(u: v, v: u) }
    init(u: Int, v: Int) {
        self.u = u
        self.v = v
    }
    var description: String { "\(u) <-> \(v)"}
}

class UnweightedGraph<V: Equatable>: Graph {
    var vertices: [V] = [V]()
    var edges: [[UnweightedEdge]] = [[UnweightedEdge]]()
    
    init() { }
    init(vertices: [V]) {
        for vertex in vertices {
            _ = self.addVertex(vertex)
        }
    }
    func addEdge(from: Int, to: Int) {
        addEdge(UnweightedEdge(u: from, v: to))
    }
    func addEdge(from: V, to: V) {
        if let u = indexOfVertex(from), let v = indexOfVertex(to) {
            addEdge(UnweightedEdge(u: u, v: v))
        }
    }
    
    var description: String {
        var d = ""
        for i in 0 ..< vertices.count {
            d += "\(vertices[i]) -> \(neighborsForIndex(i))\n"
        }
        return d
    }
}
