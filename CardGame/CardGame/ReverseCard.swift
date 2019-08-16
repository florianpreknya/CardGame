//
//  ReverseCard.swift
//  CardGame
//
//  Created by Florian Preknya on 8/14/19.
//  Copyright © 2019 Florian Preknya. All rights reserved.
//

import Foundation

class ReverseCard: Card {
    
    func matches(byNumber card: Card) -> Bool {
        
        // matches anything!
        return true
    }
    
    func matches(byColor card: Card) -> Bool {

        // matches anything!
        return true
    }
    
    var isReverseCard: Bool {
        return true
    }
    
    var description: String {
        return "reverse"
    }
}
