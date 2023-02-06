//
//  PokemonDetailsViewModel_Tests.swift
//  PokemonTests
//
//  Created by Nathaniel Brion Sison on 2/5/23.
//

import XCTest
@testable import Pokemon

final class PokemonDetailsViewModel_Tests: XCTestCase {
    private var viewModel: PokemonDetailsViewModel!
    
    override func tearDown() {
        viewModel = nil
    }
    
    func test_fetchPokemonDetails_detailsShouldBeNilWhenFailed() {
        // arrange
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.shouldReturnSuccess = false
        
        viewModel = PokemonDetailsViewModel(id: "1", pokemonDataSource: fakeDataSource)
        
        // act
        viewModel.fetchPokemonDetails(completion: { _ in })
        
        // assert
        XCTAssertNil(viewModel.pokemonName)
        XCTAssertNil(viewModel.typesText)
        XCTAssertNil(viewModel.weightText)
        XCTAssertNil(viewModel.heightText)
        XCTAssertNil(viewModel.imageUrl)
    }
    
    func test_pokemonName_shouldBeCapitalized() {
        // arrange
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonDetails = PokemonTestHelper.getFakePokemonDetails()
        
        viewModel = PokemonDetailsViewModel(id: "1", pokemonDataSource: fakeDataSource)
        
        // act
        viewModel.fetchPokemonDetails(completion: { _ in })
        
        // assert
        let expectedPokemonName = "Bulbasaur"
        let actualPokemonName = viewModel.pokemonName
        XCTAssert(expectedPokemonName == actualPokemonName)
    }
    
    func test_typesText() {
        // arrange
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonDetails = PokemonTestHelper.getFakePokemonDetails()
        
        viewModel = PokemonDetailsViewModel(id: "1", pokemonDataSource: fakeDataSource)
        
        // act
        viewModel.fetchPokemonDetails(completion: { _ in })
        
        // assert
        let expectedTypesText = "Types: Grass, Poison"
        let actualTypesText = viewModel.typesText
        XCTAssert(expectedTypesText == actualTypesText)
    }
    
    func test_weightText() {
        // arrange
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonDetails = PokemonTestHelper.getFakePokemonDetails()
        
        viewModel = PokemonDetailsViewModel(id: "1", pokemonDataSource: fakeDataSource)
        
        // act
        viewModel.fetchPokemonDetails(completion: { _ in })
        
        // assert
        let expectedWeightText = "Weight: 69kg"
        let actualWeightText = viewModel.weightText
        XCTAssert(expectedWeightText == actualWeightText)
    }
    
    func test_heightText() {
        // arrange
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonDetails = PokemonTestHelper.getFakePokemonDetails()
        
        viewModel = PokemonDetailsViewModel(id: "1", pokemonDataSource: fakeDataSource)
        
        // act
        viewModel.fetchPokemonDetails(completion: { _ in })
        
        // assert
        let expectedHeightText = "Height: 7cm"
        let actualHeightText = viewModel.heightText
        XCTAssert(expectedHeightText == actualHeightText)
    }
    
    func test_imageUrl_shouldNotBeNil() {
        // arrange
        let fakeDataSource = FakePokemonDataSource()
        fakeDataSource.fakePokemonDetails = PokemonTestHelper.getFakePokemonDetails()
        
        viewModel = PokemonDetailsViewModel(id: "1", pokemonDataSource: fakeDataSource)
        
        // act
        viewModel.fetchPokemonDetails(completion: { _ in })
        
        // assert
        XCTAssertNotNil(viewModel.imageUrl)
    }
}
