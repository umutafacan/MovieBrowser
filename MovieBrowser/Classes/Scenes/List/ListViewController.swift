//
//  ViewController.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 09/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel: ListViewModelInterface!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListCollectionViewCell.defaultNib,
                                forCellWithReuseIdentifier: ListCollectionViewCell.cellIdentifier)

        addChangeObserver()
        
        viewModel.loadMovies()
    }
}

private extension ListViewController {

    func addChangeObserver() {
        viewModel.stateChangeHandler = { [unowned self] change in
            self.applyChange(change)
        }
    }

    func applyChange(_ change: ListState.Change) {
        switch change {
        case .loading(let isLoading):
        // TODO: toggle loading
            break
        case .movies:
            collectionView.reloadData()
        }
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCollectionViewCell.cellIdentifier,
            for: indexPath) as? ListCollectionViewCell else {
                return UICollectionViewCell(frame: .zero)
        }

        let movie = viewModel.movies[indexPath.item]
        cell.title = movie.title
        cell.imagePath = movie.posterPath

        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: To be implemeted
        let height: CGFloat = 100
        let width = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
}

extension ListViewController: NibLoadable { }
