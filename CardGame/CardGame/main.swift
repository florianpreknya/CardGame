//
//  main.swift
//  CardGame
//
//  Created by Florian Preknya on 8/14/19.
//  Copyright © 2019 Florian Preknya. All rights reserved.
//

import Foundation

func createDeck(withReversibleCards reversibleCardsCount: Int = 8) -> [Card] {
    
    var cards: [Card] = []
    (1...9).forEach { value in
        let colors: [Card.Color] = [.blue, .green, .red, .yellow]
        colors.forEach { color in
            cards.append(Card.number(value: value, color: color))
        }
    }
    
    (0..<reversibleCardsCount).forEach { _ in
        cards.append(Card.reverse)
    }
    
    return cards.shuffled()
}


let players: [Player] = [
    Player(name: "Bob"),
    Player(name: "Alice"),
    Player(name: "Carol")
]

do {
    let game = try Game(players: players)
    game.verbose = true
    
    let deck = createDeck()
    print("Deck: \(deck)\n")

    if let winner = try game.play(with: deck) {
        print("\(winner.name) wins!")
    } else {
        print("No winner")
    }
    
} catch GameError.notEnoughPlayers {
    print("Not enough players!")
} catch GameError.notEnoughCards {
    print("Not enough cards!")
} catch GameError.unknownCard {
    print("Unknown card!")
}
