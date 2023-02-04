//
//  PokemonTestHelper.swift
//  PokemonTests
//
//  Created by Nathaniel Brion Sison on 2/4/23.
//

import Foundation
@testable import Pokemon

class PokemonTestHelper {
    static func getFakePokemonList(pokemonName: String = "bulbasaur",
                                   urlString: String = "https://pokeapi.co/api/v2/pokemon/1/",
                                   count: Int) -> [RemotePokemonListItem] {
        
        return Array(repeating: RemotePokemonListItem(name: pokemonName,
                                                      url: URL(string: urlString)!),
                     count: count)
    }
    
    static func getFakePokemonDetails() -> RemotePokemonDetails {
        RemotePokemonDetails(name: "bulbasaur",
                             weight: 69,
                             height: 7,
                             types: [RemotePokemonType(slot: 1, type: RemotePokemonTypeResource(name: "grass")),
                                     RemotePokemonType(slot: 2, type: RemotePokemonTypeResource(name: "poison"))],
                             sprites: RemotePokemonSprites(frontDefault: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!))
    }
}
