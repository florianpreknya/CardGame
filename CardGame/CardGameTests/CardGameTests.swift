//
//  CardGameTests.swift
//  CardGameTests
//
//  Created by Florian Preknya on 8/14/19.
//  Copyright © 2019 Florian Preknya. All rights reserved.
//

import XCTest

class CardGameTests: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testGameWithWinner() {
        
        let players: [Player] = [
            Player(name: "Bob"),
            Player(name: "Alice"),
            Player(name: "Carol")
        ]
        
        do {
            let game = try Game(players: players)
            
            let deck: [Card] = [
                Card.number(value: 2, color: .red),
                Card.number(value: 4, color: .yellow),
                Card.reverse,
                Card.number(value: 2, color: .green),
                Card.reverse,
                Card.number(value: 6, color: .red),
                Card.number(value: 6, color: .blue),
                Card.number(value: 8, color: .blue),
                Card.number(value: 8, color: .green),
                Card.number(value: 5, color: .red)
            ]
            
            let winner = try game.play(with: deck)
            XCTAssertNotNil(winner, "No winner in a winning situation... Hmm!")
        } catch {
            XCTAssert(false, "Shouldn't have any exception!")
        }
    }
    
    func testGameWithoutWinner() {
        
        let players: [Player] = [
            Player(name: "Bob"),
            Player(name: "Alice"),
            Player(name: "Carol")
        ]
        
        do {
            let game = try Game(players: players)
            
            let deck: [Card] = [
                Card.number(value: 1, color: .red),
                Card.number(value: 2, color: .yellow),
                Card.number(value: 3, color: .yellow),
                Card.number(value: 4, color: .green),
                Card.reverse,
                Card.number(value: 5, color: .red),
                Card.number(value: 6, color: .blue),
                Card.number(value: 7, color: .blue),
                Card.number(value: 8, color: .green),
                Card.number(value: 9, color: .red)
            ]
            
            let winner = try game.play(with: deck)
            XCTAssertNil(winner, "We should not have a winner... Hmm!")
        } catch {
            XCTAssert(false, "Shouldn't have any exception!")
        }
    }

    func testNotEnoughPlayers() {
        
        let players: [Player] = [
            Player(name: "Bob")
        ]
        
        XCTAssertThrowsError(try Game(players: players)) { error in
            XCTAssertEqual(error as! GameError, GameError.notEnoughPlayers)
        }
    }
    
    func testNotEnoughCards() {
        
        let players: [Player] = [
            Player(name: "Bob"),
            Player(name: "Alice"),
            Player(name: "Carol")
        ]
        
        do {
            let game = try Game(players: players)
            
            let deck: [Card] = [
                Card.number(value: 2, color: .red),
                Card.number(value: 4, color: .yellow),
                Card.reverse,
                Card.number(value: 2, color: .green),
                Card.reverse,
                Card.number(value: 6, color: .red),
                Card.number(value: 6, color: .blue),
            ]
            
            XCTAssertThrowsError(try game.play(with: deck)) { error in
                XCTAssertEqual(error as! GameError, GameError.notEnoughCards)
            }
        } catch {
            XCTAssert(false, "Shouldn't have any exception!")
        }
    }
}
