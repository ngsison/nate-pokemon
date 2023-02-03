//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import UIKit
import ZoogleAnalytics

class PokemonListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let loadingReuseIdentifier = "loading"
    private let pokemonItemReuseIdentifier = "pokemon"
    
    var viewModel: PokemonListViewModel
    
    init(viewModel: PokemonListViewModel = PokemonListViewModel(pokemonDataSource: RemotePokemonDataSource.shared)) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = PokemonListViewModel(pokemonDataSource: RemotePokemonDataSource.shared)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        title = "Pokemon"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: loadingReuseIdentifier)
        tableView.register(UINib(nibName: "PokemonListItemTableViewCell", bundle: nil), forCellReuseIdentifier: pokemonItemReuseIdentifier)
    }
    
    private func fetchMorePokemon() {
        viewModel.fetchMorePokemon { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.pokemonFetchSucceeded()
                }
            } else {
                DispatchQueue.main.async {
                    self?.pokemonFetchFailed()
                }
            }
        }
    }
    
    private func pokemonFetchSucceeded() {
        tableView.reloadData()
    }
    
    private func pokemonFetchFailed() {
        let alert = UIAlertController(title: nil,
                                      message: "We could not fetch some Pokemon, please try again later.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion:nil)
    }
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if indexPath.row >= viewModel.pokemonCount {
            cell = tableView.dequeueReusableCell(withIdentifier: loadingReuseIdentifier)
            fetchMorePokemon()
        } else if let pokemonCell = tableView.dequeueReusableCell(withIdentifier: pokemonItemReuseIdentifier) as? PokemonListItemTableViewCell {
            pokemonCell.titleLabel.text = viewModel.pokemonName(at: indexPath.row)
            cell = pokemonCell
        }
        
        guard let cell = cell else {
            fatalError("Could not find a cell")
        }
        
        return cell
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.hasPokemonCell(at: indexPath.row) else {
            return
        }
        
        guard let pokemonId = viewModel.pokemonId(at: indexPath.row) else {
            pokemonIdNotFound()
            return
        }
        
        ZoogleAnalytics.shared.log(event: ZoogleAnalyticsEvent(key: "pokemon_selected", parameters: ["id": pokemonId]))
        
        navigationController?.show(PokemonDetailsViewController(id: pokemonId), sender: self)
    }
    
    private func pokemonIdNotFound() {
        let alert = UIAlertController(title: nil,
                                      message: "We could not open details of this Pokemon, please try again later.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion:nil)
    }
}
