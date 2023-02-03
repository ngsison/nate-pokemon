//
//  ZoogleAnalyticsLogger.swift
//  Pokemon
//
//  Created by Nathaniel Brion Sison on 2/4/23.
//

import ZoogleAnalytics

class ZoogleAnalyticsLogger: PokemonLogger {
    
    static let shared = ZoogleAnalyticsLogger()
    private init() {}
    
    func logEvent(key: PokemonEventKey, parameters: [String : String]) {
        ZoogleAnalytics.shared.log(event: ZoogleAnalyticsEvent(key: key.rawValue, parameters: parameters))
    }
}
