//
//  Card.swift
//  CardGame
//
//  Created by Florian Preknya on 8/14/19.
//  Copyright © 2019 Florian Preknya. All rights reserved.
//

import Foundation

enum Card {
    
    enum Color: StringLiteralType {
        case red
        case green
        case blue
        case yellow
    }
    
    enum MatchValue: Int {
        case byColor = 3
        case byNumber = 2
        case other = 1
        case none = 0
    }
    
    case number(value: Int, color: Color)
    case reverse
    
    func matches(_ otherCard: Card) -> MatchValue {
        
        switch self {
        case .reverse:
            return .other
        case .number(let value, let color):
            switch otherCard {
            case .reverse:
                return .none
            case .number(let otherValue, let otherColor):
                if color == otherColor {
                    return .byColor
                } else if value == otherValue {
                    return .byNumber
                } else {
                    return .none
                }
            }
        }
    }
}

extension Card: CustomStringConvertible {
    var description: String {
        switch self {
        case .number(let value, let color):
            return  "\(value)-\(color.rawValue)"
        case .reverse:
            return "reverse"
        }
    }
}
