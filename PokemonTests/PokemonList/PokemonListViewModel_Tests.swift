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
    
    override func tearDown() {
        viewModel = nil
    }
    
    func test_pokemonCount_shouldReturnPokemonListResultsCount() {
        // arrange
        let fakePokemonList = RemotePokemonList(results: PokemonTestHelper.getFakePokemons(count: 20),
                                                count: 100)
        
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonList = fakePokemonList
        
        viewModel = PokemonListViewModel(pokemonDataSource: fakeDataSource,
                                         pokemonLogger: FakePokemonLogger())
        
        // act
        viewModel.fetchMorePokemon(completion: { _ in })
        
        // assert
        let expectedPokemonCount = fakePokemonList.results.count
        let actualPokemonCount = viewModel.pokemonCount
        XCTAssert(expectedPokemonCount == actualPokemonCount)
    }
    
    func test_numberOfRows_shouldReturnPokemonListResultsCountPlusOne() {
        // arrange
        let fakePokemonList = RemotePokemonList(results: PokemonTestHelper.getFakePokemons(count: 20),
                                                count: 100)
        
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonList = fakePokemonList
        
        viewModel = PokemonListViewModel(pokemonDataSource: fakeDataSource,
                                         pokemonLogger: FakePokemonLogger())
        
        // act
        viewModel.fetchMorePokemon(completion: { _ in })
        
        // assert
        let expectedNumberOfRows = fakePokemonList.results.count + 1
        let actualNumberOfRows = viewModel.numberOfRows
        XCTAssert(expectedNumberOfRows == actualNumberOfRows)
    }
    
    func test_numberOfRows_shouldReturnPokemonListResultsCount() {
        // arrange
        let fakePokemonList = RemotePokemonList(results: PokemonTestHelper.getFakePokemons(count: 100),
                                                count: 100)
        
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonList = fakePokemonList
        
        viewModel = PokemonListViewModel(pokemonDataSource: fakeDataSource,
                                         pokemonLogger: FakePokemonLogger())
        
        // act
        viewModel.fetchMorePokemon(completion: { _ in })
        
        // assert
        let expectedNumberOfRows = fakePokemonList.results.count
        let actualNumberOfRows = viewModel.numberOfRows
        XCTAssert(expectedNumberOfRows == actualNumberOfRows)
    }
    
    func test_pokemonName_shouldBeCapitalized() {
        // arrange
        let fakePokemonList = RemotePokemonList(results: PokemonTestHelper.getFakePokemons(count: 100),
                                                count: 100)
        
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonList = fakePokemonList
        
        viewModel = PokemonListViewModel(pokemonDataSource: fakeDataSource,
                                         pokemonLogger: FakePokemonLogger())
        
        // act
        viewModel.fetchMorePokemon(completion: { _ in })
        
        // assert
        let expectedPokemonName = fakePokemonList.results.first!.name.capitalized
        let actualPokemonName = viewModel.pokemonName(at: 0)
        XCTAssert(expectedPokemonName == actualPokemonName)
    }
    
    func test_hasPokemonCell_shouldReturnTrue() {
        // arrange
        let fakePokemonList = RemotePokemonList(results: PokemonTestHelper.getFakePokemons(count: 100),
                                                count: 100)
        
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonList = fakePokemonList
        
        viewModel = PokemonListViewModel(pokemonDataSource: fakeDataSource,
                                         pokemonLogger: FakePokemonLogger())
        
        // act
        viewModel.fetchMorePokemon(completion: { _ in })
        
        // assert
        let indexHasPokemonCell = viewModel.hasPokemonCell(at: 99)
        XCTAssert(indexHasPokemonCell)
    }
    
    func test_hasPokemonCell_shouldReturnFalse() {
        // arrange
        let fakePokemonList = RemotePokemonList(results: PokemonTestHelper.getFakePokemons(count: 100),
                                                count: 100)
        
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonList = fakePokemonList
        
        viewModel = PokemonListViewModel(pokemonDataSource: fakeDataSource,
                                         pokemonLogger: FakePokemonLogger())
        
        // act
        viewModel.fetchMorePokemon(completion: { _ in })
        
        // assert
        let indexHasPokemonCell = viewModel.hasPokemonCell(at: 100)
        XCTAssertFalse(indexHasPokemonCell)
    }
    
    func test_hasLoadingIndicatorCell_shouldReturnTrue() {
        // arrange
        let fakePokemonList = RemotePokemonList(results: PokemonTestHelper.getFakePokemons(count: 100),
                                                count: 100)
        
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonList = fakePokemonList
        
        viewModel = PokemonListViewModel(pokemonDataSource: fakeDataSource,
                                         pokemonLogger: FakePokemonLogger())
        
        // act
        viewModel.fetchMorePokemon(completion: { _ in })
        
        // assert
        let indexHasLoadingIndicatorCell = viewModel.hasLoadingIndicatorCell(at: 100)
        XCTAssert(indexHasLoadingIndicatorCell)
    }
    
    func test_hasLoadingIndicatorCell_shouldReturnFalse() {
        // arrange
        let fakePokemonList = RemotePokemonList(results: PokemonTestHelper.getFakePokemons(count: 100),
                                                count: 100)
        
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonList = fakePokemonList
        
        viewModel = PokemonListViewModel(pokemonDataSource: fakeDataSource,
                                         pokemonLogger: FakePokemonLogger())
        
        // act
        viewModel.fetchMorePokemon(completion: { _ in })
        
        // assert
        let indexHasLoadingIndicatorCell = viewModel.hasLoadingIndicatorCell(at: 99)
        XCTAssertFalse(indexHasLoadingIndicatorCell)
    }
    
    func test_logPokemonSelected_isWorking() {
        // arrange
        let fakePokemonLogger = FakePokemonLogger()
        viewModel = PokemonListViewModel(pokemonDataSource: FakePokemonDataSource(),
                                         pokemonLogger: fakePokemonLogger)
        
        // act
        viewModel.logPokemonSelected(pokemonId: "pokemon1")
        viewModel.logPokemonSelected(pokemonId: "pokemon2")
        viewModel.logPokemonSelected(pokemonId: "pokemon3")
        
        // assert
        XCTAssert(fakePokemonLogger.loggedEventsCount == 3)
    }
}
