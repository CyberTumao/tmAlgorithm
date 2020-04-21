//
//  PokerTest.swift
//  tmAlgorithm
//
//  Created by tumao on 2020/4/19.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

typealias Card = Int
typealias Poker = [Card]
//struct Poker: Comparable {
//    let card: Card
//    static func < (lhs: Poker, rhs: Poker) -> Bool {
//        lhs.card < rhs.card
//    }
//}

struct Person {
    var poker: Queue<Card>
    
    mutating func winCards(_ cards: Poker) {
        for card in cards {
            poker.push(card)
        }
    }
    /// 出牌
    /// - Returns: nil表示当前没有手牌
    mutating func popCard() -> Card? {
        poker.pop()
    }
    func isEmpty() -> Bool {
        poker.isEmpty
    }
}

struct Playground {
    var cards: Poker
    
    /// 把牌放入playground
    /// - Parameter card: 放下的牌
    /// - Returns: 有重复牌返回拿起的牌，没有重复牌返回nil
    mutating func push(card: Card) -> Poker? {
        cards.append(card)
        if cards.count == 1 { return nil }
        for i in 0 ... cards.count - 2 {
            if cards[i] == cards[cards.count - 1] {
                let result = Poker(cards[i ... cards.count - 1])
                cards.removeLast(cards.count - i)
                return result
            }
        }
        return nil
    }
}

func pokerTest() {
    func Fisher_Yates_shuffle(_ cards: inout Poker) {
        srand48(time(nil))
        for i in (1 ..< cards.count).reversed() {
            let random = Int(drand48() * Double(i + 1))
            cards.swapAt(i, random)
        }
    }
    
    func insertCards(_ cards: inout Poker, card: Card) {
        for _ in 0 ... 3 {
            var random = Int(drand48() * 51)
            while cards[random] != 0 {
                if random < 51 {
                    random += 1
                } else {
                    random -= 51
                }
            }
            cards[random] = card
        }
    }
    
    /// 牌堆
    var cards: Poker = Array(repeating: 0, count:13 * 4)
    //Fisher-Yates shuffle
    for j in 0 ... 3 {
        for i in 1 ... 13 {
            cards[j * 13 + i - 1] = i
        }
    }
    Fisher_Yates_shuffle(&cards)
    print("cards:\(cards)")
//    srand48(time(nil))
//    for i in 1 ... 13 {
//        insertCards(&cards, card: i)
//    }
    
    var tom = Person(poker: Queue<Card>())
    var jerry = Person(poker: Queue<Card>())
    for item in cards.enumerated() {
        if item.offset % 2 == 0 {
            tom.poker.push(item.element)
        } else {
            jerry.poker.push(item.element)
        }
    }
    var turn: Bool = true
    var playground = Playground(cards: [])
    var count = 0
    while true {
        if turn {
//            print("tom:\(tom.poker)")
            guard let tomCard = tom.popCard() else {
                print("Tom lose!")
                print("Total:\(count)")
                return
            }
            count += 1
            let result: Poker? = playground.push(card: tomCard)
            if result != nil {
                tom.winCards(result!)
            } else {
                turn = !turn
            }
        }
        if !turn {
//            print("jerry:\(jerry.poker)")
            guard let jerryCard = jerry.popCard() else {
                print("Jerry lose!")
                print("Total:\(count)")
                return
            }
            count += 1
            let result = playground.push(card: jerryCard)
            if result != nil {
                jerry.winCards(result!)
            } else {
                turn = !turn
            }
        }
    }
}
