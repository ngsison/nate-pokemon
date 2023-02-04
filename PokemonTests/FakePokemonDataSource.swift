//
//  FakePokemonDataSource.swift
//  PokemonTests
//
//  Created by Nathaniel Brion Sison on 2/4/23.
//

import Foundation
@testable import Pokemon

class FakePokemonDataSource: PokemonDataSource {
    
    var shouldReturnSuccess = true
    var fakePokemonList: RemotePokemonList?
    var fakePokemonDetails: RemotePokemonDetails?
    
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<Pokemon.RemotePokemonList, Error>) -> Void) {
        if shouldReturnSuccess, let fakePokemonList {
            completion(.success(fakePokemonList))
        } else {
            completion(.failure(NSError(domain: "", code: -1)))
        }
    }
    
    func getPokemonDetails(id: String, completion: @escaping (Result<Pokemon.RemotePokemonDetails, Error>) -> Void) {
        if shouldReturnSuccess, let fakePokemonDetails {
            completion(.success(fakePokemonDetails))
        } else {
            completion(.failure(NSError(domain: "", code: -1)))
        }
    }
}
