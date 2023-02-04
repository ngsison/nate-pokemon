//
//  FakePokemonLogger.swift
//  PokemonTests
//
//  Created by Nathaniel Brion Sison on 2/4/23.
//

import Foundation
@testable import Pokemon

class FakePokemonLogger: PokemonLogger {
    
    var loggedEventsCount = 0
    
    func logEvent(key: Pokemon.PokemonEventKey, parameters: [String : String]) {
        loggedEventsCount += 1
    }
}
