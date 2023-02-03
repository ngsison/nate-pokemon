//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Nathaniel Brion Sison on 2/3/23.
//

import Foundation

class PokemonListViewModel {
    
    private var pokemonDataSource: PokemonDataSource
    private var morePokemonToLoad = true
    private var pokemonList = [RemotePokemonListItem]()
    
    init(pokemonDataSource: PokemonDataSource) {
        self.pokemonDataSource = pokemonDataSource
    }
    
    func fetchMorePokemon(completion: @escaping (Bool) -> Void) {
        pokemonDataSource.getPokemonList(offset: pokemonList.count, limit: 20) { [weak self] result in
            guard let self else {
                completion(false)
                return
            }
            
            switch result {
            case .success(let pokemonList):
                self.pokemonList.append(contentsOf: pokemonList.results)
                self.morePokemonToLoad = self.pokemonList.count < pokemonList.count
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}

// MARK: - Pokemon Getters

extension PokemonListViewModel {
    var pokemonCount: Int {
        pokemonList.count
    }
    
    var numberOfRows: Int {
        morePokemonToLoad
            ? pokemonCount + 1
            : pokemonCount
    }
    
    func pokemonId(at index: Int) -> String? {
        pokemonList[index].id
    }
    
    func pokemonName(at index: Int) -> String {
        pokemonList[index].name.capitalized
    }
    
    func hasPokemonCell(at index: Int) -> Bool {
        index < pokemonCount
    }
    
    func hasLoadingIndicatorCell(at index: Int) -> Bool {
        index == pokemonCount
    }
}
