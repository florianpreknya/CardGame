//
//  NumberCard.swift
//  CardGame
//
//  Created by Florian Preknya on 8/14/19.
//  Copyright © 2019 Florian Preknya. All rights reserved.
//

import Foundation

class NumberCard: Card {
    
    enum Color: StringLiteralType {
        case red
        case green
        case blue
        case yellow
    }
    
    let color: Color
    let number: Int
    
    init(number: Int, color: Color) {
        self.number = number
        self.color = color
    }
    
    func matches(byNumber card: Card) -> Bool {
        
        if let card = card as? NumberCard {
            return card.number == self.number
        }
        
        // we'll be conservative, we do not know of other card types...
        return false
    }
    
    func matches(byColor card: Card) -> Bool {
        
        if let card = card as? NumberCard {
            return card.color == self.color
        }
        
        // we'll be conservative, we do not know of other types...
        return false
    }
    
    var isReverseCard: Bool {
        return false
    }
    
    var description: String {
        return "\(number)-\(color.rawValue)"
    }
}
