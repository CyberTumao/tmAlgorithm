//
//  WeightedGraph.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/22.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

protocol Summable {
    static func +(lhs: Self, rhs: Self) -> Self
}

extension Int: Summable {
    
}

class WeightedEdge<W: Comparable & Summable>: Edge, Comparable {
    var u: Int
    var v: Int
    let weight: W
    
    init(u: Int, v: Int, weight: W) {
        self.u = u
        self.v = v
        self.weight = weight
    }
    
    var reserved: Edge { WeightedEdge(u: v, v: u, weight: weight)}
    
    static func < (lhs: WeightedEdge<W>, rhs: WeightedEdge<W>) -> Bool {
        lhs.weight < rhs.weight
    }
    
    var description: String { "\(u) <\(weight)> \(v)" }
    
    static func == (lhs: WeightedEdge<W>, rhs: WeightedEdge<W>) -> Bool {
        lhs.u == rhs.u && lhs.v == rhs.v && lhs.weight == rhs.weight
    }
    
}

class WeightedGraph<V: Equatable & Hashable, W: Comparable & Summable >: Graph {
    var vertices: [V] = [V]()
    var edges: [[WeightedEdge<W>]] = [[WeightedEdge<W>]]()
    
    public init(vertices: [V]) {
        for vertex in vertices {
            _  = self.addVertex(vertex)
        }
    }
    func neightborsForIndexWithWeights(_ index: Int) -> [(V, W)] {
        var distanceTuples = [(V, W)]()
        for edge in edges[index] {
            distanceTuples.append((vertices[edge.v], edge.weight))
        }
        return distanceTuples
    }
    /// This is a convenience method that adds a weighted edge.
    ///
    /// - parameter from: The starting vertex's index.
    /// - parameter to: The ending vertex's index.
    /// - parameter weight: the Weight of the edge to add.
    public func addEdge(from: Int, to: Int, weight:W) {
       addEdge(WeightedEdge<W>(u: from, v: to, weight: weight))
    }

    /// This is a convenience method that adds a weighted edge between the first occurence of two vertices. It takes O(n) time.
    ///
    /// - parameter from: The starting vertex.
    /// - parameter to: The ending vertex.
    /// - parameter weight: the Weight of the edge to add.
    public func addEdge(from: V, to: V, weight: W) {
       if let u = indexOfVertex(from) {
           if let v = indexOfVertex(to) {
               addEdge(WeightedEdge<W>(u: u, v: v, weight:weight))
           }
       }
    }
    var description: String {
        var d = ""
        for i in 0 ..< vertices.count {
            d += "\(vertices[i]) -> \(neightborsForIndexWithWeights(i))\n"
        }
        return d
    }
}
