//
//  DetailViewController.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: ImageView! {
        didSet {
            imageView.imageWidth = 500
            imageView.contentMode = .scaleAspectFill
        }
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
            titleLabel.font = .boldSystemFont(ofSize: 17)
        }
    }

    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = .systemFont(ofSize: 14)
        }
    }

    @IBOutlet weak var bottomLabel: UILabel! {
        didSet {
            bottomLabel.numberOfLines = 0
        }
    }

    var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        bindChangeHandler()
        viewModel.loadPage()
    }
}

extension DetailViewController {

    func bindChangeHandler() {
        viewModel.stateChangeHandler = { [unowned self] change in
            self.applyChange(change)
        }
    }

    func applyChange(_ change: DetailState.Change) {
        switch change {
        case .imageSource(let path):
            imageView.imagePath = path
        case .loading(let isLoading):
            toggleIndicatingActivity(isLoading)
        case .movieInfo(let movieInfo):
            titleLabel.text = movieInfo?.title
            descriptionLabel.text = movieInfo?.description
        case .vote(let vote):
            guard let vote = vote else  { return }
            bottomLabel.text = "Avarage: \(vote.avarage) by \(vote.count) votes"
        case .favorite(let isFavorite):
            configureFavoriteButton(isFavorite: isFavorite)
        }
    }
}

extension DetailViewController {

    func configureNavigationBar() {
        // TODO: Localize
        navigationItem.title = "Movie Detail"
    }

    func configureFavoriteButton(isFavorite: Bool) {

        let image = isFavorite ? UIImage(named: "filled_star") : UIImage(named: "empty_star")

        let button = UIBarButtonItem(image: image,
                                     style: .plain,
                                     target: self,
                                     action: #selector(favoriteButtonTapped))

        navigationItem.setRightBarButton(button, animated: true)
    }

    @objc
    func favoriteButtonTapped() {
        viewModel.toggleFavoriteOption()
    }
}

extension DetailViewController: NibLoadable { }
