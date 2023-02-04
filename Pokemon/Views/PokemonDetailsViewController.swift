//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var loadingView: UIView!
    
    private var viewModel: PokemonDetailsViewModel
    
    init(viewModel: PokemonDetailsViewModel) {
        self.viewModel = viewModel
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
        viewModel.fetchPokemonDetails { success in
            if success {
                DispatchQueue.main.async {
                    self.pokemonFetchSucceeded()
                }
            } else {
                DispatchQueue.main.async {
                    self.pokemonFetchFailed()
                }
            }
        }
    }

    private func pokemonFetchSucceeded() {
        titleLabel.text = viewModel.pokemonName
        typesLabel.text = viewModel.typesText
        weightLabel.text = viewModel.weightText
        heightLabel.text = viewModel.heightText
        
        if let imageUrl = viewModel.imageUrl {
            imageView.setURL(imageUrl) { [weak self] success in
                if !success {
                    self?.imageView.image = UIImage(named: "unknown")
                }
                self?.loadingView.isHidden = true
            }
        }
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
