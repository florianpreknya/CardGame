//
//  Player.swift
//  CardGame
//
//  Created by Florian Preknya on 8/14/19.
//  Copyright © 2019 Florian Preknya. All rights reserved.
//

import Foundation

class Player {
    
    let name: String
    
    // an empty hand means a winner (when in a game session)
    var hasEmptyHand: Bool {
        return cards.isEmpty
    }

    // the cards from player's hand
    fileprivate var cards: [Card] = []
    
    init(name: String) {
        self.name = name
    }
    
    /// Gives the hand of cards to this player when a game session starts.
    func setHand(_ cards: [Card]) {
        self.cards = cards
    }
    
    /// Discards one card on top of the pile
    func discard(on pileCard: NumberCard) -> Card? {
        
        // matching rules, in order: color, number or reverse card
        guard let matchingCardIndex =
            cards.firstIndex(where: { card in !card.isReverseCard && card.matches(byColor: pileCard)}) ??
            cards.firstIndex(where: { card in !card.isReverseCard && card.matches(byNumber: pileCard)}) ??
            cards.firstIndex(where: { card in card.isReverseCard }) else {
                
                // nothing matches
                return nil
        }

        return cards.remove(at: matchingCardIndex)
    }
}

extension Player: CustomStringConvertible {
    var description: String {
        let hand = cards.map { $0.description }.joined(separator: ", ")
        return "\(name): \(hand)"
    }
}
