//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    private let id: String

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var loadingView: UIView!

    init(id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemonDetails()
    }

    private func fetchPokemonDetails() {
        loadingView.isHidden = false
        RemotePokemonDataSource.shared.getPokemonDetails(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let details):
                    self?.pokemonFetchSucceeded(details: details)
                case .failure(_):
                    self?.pokemonFetchFailed()
                }
            }
        }
    }

    private func pokemonFetchSucceeded(details: RemotePokemonDetails) {
        titleLabel.text = details.name.capitalized

        let types = details.types.map({ type in
            type.type.name.capitalized
        }).joined(separator: ", ")
        
        typesLabel.text = "Types: \(types)"

        weightLabel.text = "Weight: \(details.weight)kg"
        heightLabel.text = "Height: \(details.height)cm"

        imageView.setURL(details.sprites.frontDefault, completion: { [weak self] success in
            if !success {
                self?.imageView.image = UIImage(named: "unknown")
            }
            self?.loadingView.isHidden = true
        })
    }

    private func pokemonFetchFailed() {
        let alert = UIAlertController(title: nil,
            message: "We could not load this Pokemon, please try again.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
            self?.fetchPokemonDetails()
        }))
        present(alert, animated: true, completion:nil)
    }
}
