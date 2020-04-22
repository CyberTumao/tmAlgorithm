//
//  GraphInstance.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/22.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

func unweightedGraph() {
    let cityGraph: UnweightedGraph<String> = UnweightedGraph<String>(vertices: ["Seattle", "San Francisco", "Los Angeles", "Riverside", "Phoenix", "Chicago", "Boston", "New York", "Atlanta", "Miami", "Dallas", "Houston", "Detroit", "Philadelphia", "Washington"])

    cityGraph.addEdge(from: "Seattle", to: "Chicago")
    cityGraph.addEdge(from: "Seattle", to: "San Francisco")
    cityGraph.addEdge(from: "San Francisco", to: "Riverside")
    cityGraph.addEdge(from: "San Francisco", to: "Los Angeles")
    cityGraph.addEdge(from: "Los Angeles", to: "Riverside")
    cityGraph.addEdge(from: "Los Angeles", to: "Phoenix")
    cityGraph.addEdge(from: "Riverside", to: "Phoenix")
    cityGraph.addEdge(from: "Riverside", to: "Chicago")
    cityGraph.addEdge(from: "Phoenix", to: "Dallas")
    cityGraph.addEdge(from: "Phoenix", to: "Houston")
    cityGraph.addEdge(from: "Dallas", to: "Chicago")
    cityGraph.addEdge(from: "Dallas", to: "Atlanta")
    cityGraph.addEdge(from: "Dallas", to: "Houston")
    cityGraph.addEdge(from: "Houston", to: "Atlanta")
    cityGraph.addEdge(from: "Houston", to: "Miami")
    cityGraph.addEdge(from: "Atlanta", to: "Chicago")
    cityGraph.addEdge(from: "Atlanta", to: "Washington")
    cityGraph.addEdge(from: "Atlanta", to: "Miami")
    cityGraph.addEdge(from: "Miami", to: "Washington")
    cityGraph.addEdge(from: "Chicago", to: "Detroit")
    cityGraph.addEdge(from: "Detroit", to: "Boston")
    cityGraph.addEdge(from: "Detroit", to: "Washington")
    cityGraph.addEdge(from: "Detroit", to: "New York")
    cityGraph.addEdge(from: "Boston", to: "New York")
    cityGraph.addEdge(from: "New York", to: "Philadelphia")
    cityGraph.addEdge(from: "Philadelphia", to: "Washington")
    
    if let bostonToMiami = cityGraph.bfs(initialVertex: "Boston", goalTestFn: { $0 == "Miami" }) {
        cityGraph.printPath(bostonToMiami)
    }
}

func weightedGraph() {
    let cityGraph2: WeightedGraph<String, Int> = WeightedGraph<String, Int>(vertices: ["Seattle", "San Francisco", "Los Angeles", "Riverside", "Phoenix", "Chicago", "Boston", "New York", "Atlanta", "Miami", "Dallas", "Houston", "Detroit", "Philadelphia", "Washington"])

    cityGraph2.addEdge(from: "Seattle", to: "Chicago", weight: 1737)
    cityGraph2.addEdge(from: "Seattle", to: "San Francisco", weight: 678)
    cityGraph2.addEdge(from: "San Francisco", to: "Riverside", weight: 386)
    cityGraph2.addEdge(from: "San Francisco", to: "Los Angeles", weight: 348)
    cityGraph2.addEdge(from: "Los Angeles", to: "Riverside", weight: 50)
    cityGraph2.addEdge(from: "Los Angeles", to: "Phoenix", weight: 357)
    cityGraph2.addEdge(from: "Riverside", to: "Phoenix", weight: 307)
    cityGraph2.addEdge(from: "Riverside", to: "Chicago", weight: 1704)
    cityGraph2.addEdge(from: "Phoenix", to: "Dallas", weight: 887)
    cityGraph2.addEdge(from: "Phoenix", to: "Houston", weight: 1015)
    cityGraph2.addEdge(from: "Dallas", to: "Chicago", weight: 805)
    cityGraph2.addEdge(from: "Dallas", to: "Atlanta", weight: 721)
    cityGraph2.addEdge(from: "Dallas", to: "Houston", weight: 225)
    cityGraph2.addEdge(from: "Houston", to: "Atlanta", weight: 702)
    cityGraph2.addEdge(from: "Houston", to: "Miami", weight: 968)
    cityGraph2.addEdge(from: "Atlanta", to: "Chicago", weight: 588)
    cityGraph2.addEdge(from: "Atlanta", to: "Washington", weight: 543)
    cityGraph2.addEdge(from: "Atlanta", to: "Miami", weight: 604)
    cityGraph2.addEdge(from: "Miami", to: "Washington", weight: 923)
    cityGraph2.addEdge(from: "Chicago", to: "Detroit", weight: 238)
    cityGraph2.addEdge(from: "Detroit", to: "Boston", weight: 613)
    cityGraph2.addEdge(from: "Detroit", to: "Washington", weight: 396)
    cityGraph2.addEdge(from: "Detroit", to: "New York", weight: 482)
    cityGraph2.addEdge(from: "Boston", to: "New York", weight: 190)
    cityGraph2.addEdge(from: "New York", to: "Philadelphia", weight: 81)
    cityGraph2.addEdge(from: "Philadelphia", to: "Washington", weight: 123)

    print(cityGraph2)
}
