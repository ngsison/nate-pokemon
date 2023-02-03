//
//  PokemonDataSource.swift
//  Pokemon
//
//  Created by Nathaniel Brion Sison on 2/3/23.
//

import Foundation

protocol PokemonDataSource {
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<RemotePokemonList, Swift.Error>) -> Void)
    func getPokemonDetails(id: String, completion: @escaping (Result<RemotePokemonDetails, Swift.Error>) -> Void)
}
