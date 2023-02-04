//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Nathaniel Brion Sison on 2/5/23.
//

import Foundation

class PokemonDetailsViewModel {
    
    private var id: String
    private var pokemonDataSource: PokemonDataSource
    private var details: RemotePokemonDetails?
    
    init(id: String, pokemonDataSource: PokemonDataSource = RemotePokemonDataSource.shared) {
        self.id = id
        self.pokemonDataSource = pokemonDataSource
    }
    
    func fetchPokemonDetails(completion: @escaping (Bool) -> Void) {
        pokemonDataSource.getPokemonDetails(id: id) { [weak self] result in
            guard let self else {
                completion(false)
                return
            }
            
            switch result {
            case .success(let details):
                self.details = details
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}

// MARK: - PokemonDetails Getters

extension PokemonDetailsViewModel {
    var pokemonName: String? {
        guard let details else { return nil }
        return details.name.capitalized
    }
    
    var typesText: String? {
        guard let details else { return nil }
        
        let types = details.types
            .map { $0.type.name.capitalized }
            .joined(separator: ", ")
        
        return "Types: \(types)"
    }
    
    var weightText: String? {
        guard let details else { return nil }
        return "Weight: \(details.weight)kg"
    }
    
    var heightText: String? {
        guard let details else { return nil }
        return "Height: \(details.height)cm"
    }
    
    var imageUrl: URL? {
        details?.sprites.frontDefault
    }
}
