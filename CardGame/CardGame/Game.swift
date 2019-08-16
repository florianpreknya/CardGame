//
//  Game.swift
//  CardGame
//
//  Created by Florian Preknya on 8/14/19.
//  Copyright © 2019 Florian Preknya. All rights reserved.
//

import Foundation

class Game {
    
    let players: [Player]
    
    init(players: [Player]) throws {
        if players.count < 2 {
            throw GameError.notEnoughPlayers
        }
        
        self.players = players
    }
    
    var verbose: Bool = false
    
    // game session state
    fileprivate var reverseDirection: Bool = false
    fileprivate var pile: [Card] = []
    fileprivate var noDiscardingPlayersCount = 0
    
    /// Giving the shuffled deck cards, starts a playing session, returning the eventual winner.
    func play(with deck: [Card]) throws -> Player? {
        
        reset()
        
        // give cards to each player and initialize the pile
        let remainingCards = try giveCardsToPlayers(from: deck)
        try initPile(from: remainingCards)
        
        if verbose {
            print("Pile: \(pile.first!)")
        }

        
        // starts the playing session, each player trying to discard his hand; we'll end the game a player emptied his hand or when there are no more cards to discard (the while condition)
        var currentPlayerIndex = -1
        while noDiscardingPlayersCount < players.count {
            
            // move to next player
            if reverseDirection {
                currentPlayerIndex -= 1
                if currentPlayerIndex < 0 {
                    currentPlayerIndex = players.count - 1
                }
            } else {
                currentPlayerIndex += 1
                if currentPlayerIndex >= players.count {
                    currentPlayerIndex = 0
                }
            }
            
            let currentPlayer = players[currentPlayerIndex]
            if let discardedCard = currentPlayer.discard(on: pile.last!) {
                switch discardedCard {
                case .number(_, _):
                    pile.append(discardedCard)
                case .reverse:
                    // change game direction
                    reverseDirection = !reverseDirection
                }
                
                if verbose {
                    print("\(currentPlayer.name) plays \(discardedCard)")
                }
                
                // reset the "not discarding" count
                noDiscardingPlayersCount = 0
                
                // check if we have a winner...
                if currentPlayer.hasEmptyHand {
                    return currentPlayer
                }
                
            } else {
                if verbose {
                    print("\(currentPlayer.name) stays...")
                }
                
                // player didn't discard anything...
                noDiscardingPlayersCount += 1
            }
        }
        
        // no winner!
        return nil
    }
    
    fileprivate func reset() {
        reverseDirection = false
        pile.removeAll()
        noDiscardingPlayersCount = 0
    }
    
    fileprivate func giveCardsToPlayers(from deck: [Card]) throws -> [Card] {
        
        var cards = deck
        for player in players {
            let hand = cards.prefix(3)
            if hand.count < 3 {
                throw GameError.notEnoughCards
            }
            
            cards.removeFirst(3)
            
            player.setHand(Array(hand))
            if verbose {
                print(player)
            }
        }
        
        return cards
    }
    
    fileprivate func initPile(from deck: [Card]) throws {
        
        if let firstNumberCard = deck.first(where: { card in
            switch card {
            case .reverse:
                return false
            case .number(_, _):
                return true
            }
        }) {
            pile = [firstNumberCard]
        } else {
            throw GameError.notEnoughCards
        }
    }
}
