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
                NumberCard(number: 2, color: .red),
                NumberCard(number: 4, color: .yellow),
                ReverseCard(),
                NumberCard(number: 2, color: .green),
                ReverseCard(),
                NumberCard(number: 6, color: .red),
                NumberCard(number: 6, color: .blue),
                NumberCard(number: 8, color: .blue),
                NumberCard(number: 8, color: .green),
                NumberCard(number: 5, color: .red)
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
                NumberCard(number: 1, color: .red),
                NumberCard(number: 2, color: .yellow),
                NumberCard(number: 3, color: .yellow),
                NumberCard(number: 4, color: .green),
                ReverseCard(),
                NumberCard(number: 5, color: .red),
                NumberCard(number: 6, color: .blue),
                NumberCard(number: 7, color: .blue),
                NumberCard(number: 8, color: .green),
                NumberCard(number: 9, color: .red)
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
                NumberCard(number: 2, color: .red),
                NumberCard(number: 4, color: .yellow),
                ReverseCard(),
                NumberCard(number: 2, color: .green),
                ReverseCard(),
                NumberCard(number: 6, color: .red),
                NumberCard(number: 6, color: .blue),
            ]
            
            XCTAssertThrowsError(try game.play(with: deck)) { error in
                XCTAssertEqual(error as! GameError, GameError.notEnoughCards)
            }
        } catch {
            XCTAssert(false, "Shouldn't have any exception!")
        }
    }
}
