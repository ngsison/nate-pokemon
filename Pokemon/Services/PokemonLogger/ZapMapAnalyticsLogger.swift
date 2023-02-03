//
//  ZapMapAnalyticsLogger.swift
//  Pokemon
//
//  Created by Nathaniel Brion Sison on 2/4/23.
//

import Foundation

class ZapMapAnalyticsLogger: PokemonLogger {
    
    static let shared = ZapMapAnalyticsLogger()
    private init() {}
    
    func logEvent(key: PokemonEventKey, parameters: [String : String]) {
        print("Logging to ZapMap analytics: key: \(key.rawValue) parameters: \(parameters)")
    }
}
