//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import UIKit
import ZoogleAnalytics

class PokemonListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!

    private var morePokemonToLoad = true
    private var pokemon = [RemotePokemonListItem]()

    private let loadingReuseIdentifier = "loading"
    private let pokemonItemReuseIdentifier = "pokemon"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: loadingReuseIdentifier)
        tableView.register(UINib(nibName: "PokemonListItemTableViewCell", bundle: nil), forCellReuseIdentifier: pokemonItemReuseIdentifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = pokemon.count
        if morePokemonToLoad {
            rowCount += 1
        }
        return rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?

        if indexPath.row >= pokemon.count {
            cell = tableView.dequeueReusableCell(withIdentifier: loadingReuseIdentifier)
            fetchMorePokemon()
        } else if let pokemonCell = tableView.dequeueReusableCell(withIdentifier: pokemonItemReuseIdentifier) as? PokemonListItemTableViewCell {
            pokemonCell.titleLabel.text = pokemon[indexPath.row].name.capitalized
            cell = pokemonCell
        }

        guard let cell = cell else {
            fatalError("Could not find a cell")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < pokemon.count else {
            return
        }

        guard let pokemonId = pokemon[indexPath.row].id else {
            pokemonIdNotFound()
            return
        }

        ZoogleAnalytics.shared.log(event: ZoogleAnalyticsEvent(key: "pokemon_selected", parameters: ["id": pokemonId]))

        navigationController?.show(PokemonDetailsViewController(id: pokemonId), sender: self)
    }

    private func fetchMorePokemon() {
        RemotePokemonDataSource.shared.getPokemonList(offset: pokemon.count) { [weak self] result in
            switch result {
            case .success(let pokemonList):
                DispatchQueue.main.async {
                    self?.pokemonFetchSucceeded(pokemonList: pokemonList)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.pokemonFetchFailed()
                }
            }
        }
    }

    private func pokemonFetchSucceeded(pokemonList: RemotePokemonList) {
        pokemon.append(contentsOf: pokemonList.results)

        if pokemon.count == pokemonList.count {
            morePokemonToLoad = false
        }

        tableView.reloadData()
    }


    private func pokemonFetchFailed() {
        let alert = UIAlertController(title: nil,
            message: "We could not fetch some Pokemon, please try again later.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion:nil)
    }

    private func pokemonIdNotFound() {
        let alert = UIAlertController(title: nil,
            message: "We could not open details of this Pokemon, please try again later.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion:nil)
    }

}
