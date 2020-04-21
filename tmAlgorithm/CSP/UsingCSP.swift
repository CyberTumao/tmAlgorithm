//
//  UsingCSP.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/19.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

enum place: String {
    case WA = "Western Australia"
    case NT = "Northern Territory"
    case SA = "South Australia"
    case Q = "Queensland"
    case NSW = "New South Wales"
    case V = "Victoria"
    case T = "Tasmania"
}

func AustralianMapCSP() {
    let variables: [String] = [place.WA.rawValue, place.NT.rawValue, place.SA.rawValue, place.Q.rawValue, place.NSW.rawValue, place.V.rawValue, place.T.rawValue]
    var domains = Dictionary<String, [String]>()
    for variable in variables {
        domains[variable] = ["r", "g", "b"]
    }
    var csp = CSP<String, String>(variables, domains: domains)
    csp.addConstraint(MapColoringConstraint(place1: place.WA.rawValue, place2: place.NT.rawValue))
    csp.addConstraint(MapColoringConstraint(place1: place.WA.rawValue, place2: place.SA.rawValue))
    csp.addConstraint(MapColoringConstraint(place1: place.SA.rawValue, place2: place.NT.rawValue))
    csp.addConstraint(MapColoringConstraint(place1: place.Q.rawValue, place2: place.NT.rawValue))
    csp.addConstraint(MapColoringConstraint(place1: place.Q.rawValue, place2: place.SA.rawValue))
    csp.addConstraint(MapColoringConstraint(place1: place.Q.rawValue, place2: place.NSW.rawValue))
    csp.addConstraint(MapColoringConstraint(place1: place.NSW.rawValue, place2: place.SA.rawValue))
    csp.addConstraint(MapColoringConstraint(place1: place.V.rawValue, place2: place.SA.rawValue))
    csp.addConstraint(MapColoringConstraint(place1: place.V.rawValue, place2: place.NSW.rawValue))
    guard let solution = backtrackingSearch(csp: csp) else {
        print("Could not find solution!")
        return
    }
    print(solution)
}

func eightQueensQuestionCSP() {
    typealias Row = Int
    typealias Col = Int
    let variables: [Row] = [Row](1 ... 8)
    var domains = Dictionary<Row, [Col]>()
    for variable in variables {
        domains[variable] = [Int](1 ... 8)
    }
    var csp = CSP<Row, Col>(variables, domains: domains)
    csp.addConstraint(QueensConstraint(columns: variables))
    guard let solution = backtrackingSearch(csp: csp) else {
        print("Could not find solution!")
        return
    }
    print(solution)
}

func wordSearchCSP() {
    let ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    func generateGrid(rows: Int, columns: Int) -> Grid {
        var grid = Grid(repeating: [Character](repeating: " ", count: columns), count: rows)
        for row in 0 ..< rows {
            for col in 0 ..< columns {
                grid[row][col] = ALPHABET[ALPHABET.index(ALPHABET.startIndex, offsetBy: Int(arc4random_uniform(UInt32(ALPHABET.count))))]
            }
        }
        return grid
    }
    func generateDomain(word: String, grid: Grid) -> [[GridLocation]] {
        var domain = [[GridLocation]]()
        let height = grid.count
        let width = grid[0].count
        let wordLength = word.count
        for row in 0 ..< height {
            for col in 0 ..< width {
                let columns = col ... (col + wordLength - 1)
                let rows = row ... (row + wordLength - 1)
                if col + wordLength <= width {
                    domain.append(columns.map({GridLocation(row: row, col: $0)}))
                    if row + wordLength <= height {
                        domain.append(rows.map({GridLocation(row: $0, col: col + $0 - row)}))
                    }
                }
                if row + wordLength <= height {
                    domain.append(rows.map({GridLocation(row: $0, col: col)}))
                    if col - wordLength >= 0 {
                        domain.append(rows.map({GridLocation(row: $0, col: col - $0 + row)}))
                    }
                }
            }
        }
        return domain
    }
    func printGrid(_ grid: Grid) {
        for i in 0 ..< grid.count {
            print(String(grid[i]))
        }
    }

    var grid = generateGrid(rows: 9, columns: 9)
    print("solution:")
    let words = ["MATTHEW", "JOE", "MARY", "SARAH", "SALLY"]
    var locations = Dictionary<String, [[GridLocation]]>()
    for word in words {
        locations[word] = generateDomain(word: word, grid: grid)
    }
    var csp = CSP<String, [GridLocation]>(words, domains:locations)
    csp.addConstraint(WordSearchConstraint(words: words))
    guard let solution = backtrackingSearch(csp: csp) else {
        print("Could not find solution!")
        return
    }
    for (word, gridLoctaions) in solution {
//        let gridLocs = arc4random_uniform(2) > 0 ? gridLoctaions : gridLoctaions.reserved()
        let gridLocs = gridLoctaions
        for (index, letter) in word.enumerated() {
            let (row, col) = (gridLocs[index].row, gridLoctaions[index].col)
            grid[row][col] = letter
        }
    }
    printGrid(grid)
}

func sendMoreMoneyCSP() {
    let variables: [Character] = ["S", "E", "N", "D", "M", "O", "R", "Y"]
    var domains = Dictionary<Character, [Int]>()
    for variable in variables {
        domains[variable] = [Int](0 ... 9)
    }
    domains["S"] = [9]
    domains["M"] = [1]
    domains["O"] = [0]
    var csp = CSP<Character, Int>(variables, domains: domains)
    csp.addConstraint(SendMoreMoneyConstraint(letters: variables))
    guard let solution = backtrackingSearch(csp: csp) else {
        print("Could not find solution!")
        return
    }
    print(solution)
}

func circuitBoardCSP() {
    var variablesGrids = [(String, CBGrid)]()
    func generateGrid(rows: Int, columns: Int, withNumber number: Int) -> CBGrid {
        CBGrid(repeating: [Int](repeating: number, count: columns), count: rows)
    }
    func generateDomain(variable: Int, grid: CBGrid) -> [[CBGridLocation]] {
        var domain = [[CBGridLocation]]()
        let height = grid.count
        let width = grid[0].count
        let variableHeight = variablesGrids[variable].1.count
        let variableWidth = (variablesGrids[variable].1)[0].count
        for row in 0 ..< height {
            for col in 0 ..< width {
                var columns = col ... (col + variableWidth - 1)
                var rows = row ... (row + variableHeight - 1)
                if col + variableWidth <= width && row + variableHeight <= height {
                    domain.append(columns.map({ c -> [CBGridLocation] in
                        rows.map { CBGridLocation(row: $0, col: c) }
                    }).flatMap { $0 })
                }
                columns = col ... (col + variableHeight - 1)
                rows = row ... (row + variableWidth - 1)
                if col + variableHeight <= width && row + variableWidth <= height {
                    domain.append(columns.map({ c -> [CBGridLocation] in
                        rows.map { CBGridLocation(row: $0, col: c) }
                    }).flatMap { $0 })
                }
            }
        }
        return domain
    }
    var grid = generateGrid(rows: 10, columns: 10, withNumber: 0)
    let variables: [String] = ["1", "2", "3", "4"]
    var domains = Dictionary<String, [[CBGridLocation]]>()
    for variable in variables.enumerated() {
        variablesGrids.append((variable.element, generateGrid(rows: variable.offset + 3, columns: variable.offset + 2, withNumber: variable.offset + 1)))
        domains[variable.element] = generateDomain(variable: variable.offset, grid: grid)
    }
    var csp = CSP<String, [CBGridLocation]>(variables, domains:domains)
    csp.addConstraint(CircuitBoardConstraint(boards: variables))
    guard let solution = backtrackingSearch(csp: csp) else {
        print("Could not find solution!")
        return
    }
    for (word, gridLoctaions) in solution {
        for location in gridLoctaions {
            let (row, col) = (location.row, location.col)
            grid[row][col] = Int(word)!
        }
    }
    for i in grid {
        print(i)
    }
}
