//
//  PokemonLogger.swift
//  Pokemon
//
//  Created by Nathaniel Brion Sison on 2/4/23.
//

import Foundation

protocol PokemonLogger {
    func logEvent(key: PokemonEventKey, parameters: [String: String])
}
