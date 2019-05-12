//
//  DetailViewController.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: ImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

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
        }
    }
}

extension DetailViewController {

    func configureNavigationBar() {
        // TODO: Localize
        navigationItem.title = "Movie Detail"
    }
}

extension DetailViewController: NibLoadable { }
