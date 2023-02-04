//
//  PokemonListViewModel_Tests.swift
//  PokemonTests
//
//  Created by Nathaniel Brion Sison on 2/4/23.
//

import XCTest
@testable import Pokemon

final class PokemonListViewModel_Tests: XCTestCase {
    private var viewModel: PokemonListViewModel!
    
    override func setUp() {
        viewModel = PokemonListViewModel(pokemonDataSource: FakePokemonDataSource(),
                                         pokemonLogger: FakePokemonLogger())
    }
}
