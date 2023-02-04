//
//  PokemonTestHelper.swift
//  PokemonTests
//
//  Created by Nathaniel Brion Sison on 2/4/23.
//

import Foundation
@testable import Pokemon

class PokemonTestHelper {
    static func getFakePokemons(count: Int) -> [RemotePokemonListItem] {
        return Array(repeating: RemotePokemonListItem(name: "pikachu", url: URL(string: "https://google.com")!),
                     count: count)
    }
}
