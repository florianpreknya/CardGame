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

    func testWinningGame() {
        
        let players: [Player] = [
            Player(name: "Bob"),
            Player(name: "Alice"),
            Player(name: "Carol")
        ]
        
        // test it first if not throws!
        XCTAssertNoThrow(try Game(players: players))

        let game = try! Game(players: players)
        
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
        
        XCTAssertNoThrow(try game.play(with: deck))
        
        let winner = try! game.play(with: deck)
        XCTAssertNotNil(winner, "No winner in a winning situation... Hmm!")

        print(winner!)
    }

}
