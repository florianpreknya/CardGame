//
//  GameException.swift
//  CardGame
//
//  Created by Florian Preknya on 8/14/19.
//  Copyright © 2019 Florian Preknya. All rights reserved.
//

import Foundation

enum GameError: Error {
    case notEnoughPlayers
    case notEnoughCards
    case unknownCard
}
