//
//  Card.swift
//  CardGame
//
//  Created by Florian Preknya on 8/14/19.
//  Copyright © 2019 Florian Preknya. All rights reserved.
//

import Foundation

protocol Card: CustomStringConvertible {
    
    func matches(byNumber: Card) -> Bool
    func matches(byColor: Card) -> Bool
    
    var isReverseCard: Bool { get }
}
