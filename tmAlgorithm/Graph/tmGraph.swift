//
//  tmGraph.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/22.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

protocol Edge: CustomStringConvertible {
    /// u,v是vertices的下标
    var u: Int { get set }
    var v: Int { get set }
    var reserved: Edge { get }
}

typealias Path = [Edge]

protocol Graph: class, CustomStringConvertible {
    associatedtype VertexType: Equatable
    associatedtype EdgeType: Edge
    var vertices: [VertexType] { get set }
    var edges: [[EdgeType]] { get set }
}

extension Graph {
    var vertexCount: Int { vertices.count }
    var edgeCount: Int { edges.joined().count }
    
    func vertexAtIndex(_ index: Int) -> VertexType {
        vertices[index]
    }
    func indexOfVertex(_ vertex: VertexType) -> Int? {
        vertices.firstIndex(of: vertex)
    }
    func neighborsForIndex(_ index: Int) -> [VertexType] {
        edges[index].map({vertices[$0.v]})
    }
    func neighborsForVertex(_ vertex: VertexType) -> [VertexType] {
        guard let i = indexOfVertex(vertex) else {
            return []
        }
        return neighborsForIndex(i)
    }
    func edgesForIndex(_ index: Int) -> [EdgeType] {
        edges[index]
    }
    func edgesForVertex(_ vertex: VertexType) -> [EdgeType] {
        guard let i = indexOfVertex(vertex) else {
            return []
        }
        return edgesForIndex(i)
    }
    func edgeForIndex(from: Int, to: Int) -> EdgeType? {
        edges[from].filter({$0.v == to}).first
    }
    func edgeForVertex(from: VertexType, to: VertexType) -> EdgeType? {
        guard let i = indexOfVertex(from), let j = indexOfVertex(to) else {
            return nil
        }
        return edgeForIndex(from: i, to: j)
    }
    func addVertex(_ v: VertexType) -> Int {
        vertices.append(v)
        edges.append([EdgeType]())
        return vertices.count - 1
    }
    func addEdge(_ e: EdgeType) {
        edges[e.u].append(e)
        edges[e.v].append(e.reserved as! EdgeType)
    }
}

extension Graph {
    func printPath(_ path: Path) {
        for edge in path {
            print("\(vertexAtIndex(edge.u)) > \(vertexAtIndex(edge.v))")
        }
    }

    func verticesArrayToPath(from: Int, to: Int, pathDict: [Int: EdgeType]) -> Path {
        if pathDict.count == 0 {
            return []
        }
        var edgePath: Path = Path()
        var e: Edge = pathDict[to]!
        edgePath.append(e)
        while e.u != from {
            e = pathDict[e.u]!
            edgePath.append(e)
        }
        return edgePath.reversed()
    }
    
    func bfs(initialVertex: VertexType, goalTestFn: (VertexType) -> Bool) -> Path? {
        guard let startIndex = indexOfVertex(initialVertex) else {
            return nil
        }
        var frointer = Queue<Int>()
        frointer.push(startIndex)
        var explored: Set<Int>  = Set<Int>()
        var pathDict: [Int: EdgeType] = [Int: EdgeType]()
        while !frointer.isEmpty {
            let currentIndex = frointer.pop()!
            let currentVertex = vertexAtIndex(currentIndex)
            if goalTestFn(currentVertex) {
                return verticesArrayToPath(from: startIndex, to: currentIndex, pathDict: pathDict)
            }
            for edge in edgesForIndex(currentIndex) where !explored.contains(edge.v) {
                explored.insert(edge.v)
                frointer.push(edge.v)
                pathDict[edge.v] = edge
            }
        }
        return nil
    }
}
