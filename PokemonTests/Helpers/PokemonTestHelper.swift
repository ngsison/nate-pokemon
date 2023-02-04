//
//  PokemonTestHelper.swift
//  PokemonTests
//
//  Created by Nathaniel Brion Sison on 2/4/23.
//

import Foundation
@testable import Pokemon

class PokemonTestHelper {
    static func getFakePokemons(pokemonName: String = "bulbasaur",
                                urlString: String = "https://pokeapi.co/api/v2/pokemon/1/",
                                count: Int) -> [RemotePokemonListItem] {
        
        return Array(repeating: RemotePokemonListItem(name: pokemonName,
                                                      url: URL(string: urlString)!),
                     count: count)
    }
}
