//
//  LocalPokemonDataSource.swift
//  Pokemon
//
//  Created by Nathaniel Brion Sison on 2/3/23.
//

import Foundation

class LocalPokemonDataSource: PokemonDataSource {
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<RemotePokemonList, Error>) -> Void) {
        // Fetch pokemon list from local storage (e.g. CoreData, UserDefaults, etc.)
    }
    
    func getPokemonDetails(id: String, completion: @escaping (Result<RemotePokemonDetails, Error>) -> Void) {
        // Fetch pokemon details from local storage (e.g. CoreData, UserDefaults, etc.)
    }
}
