//
//  ViewController.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 09/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

    private enum Constant {
        static let buttonHeight: CGFloat = 50.0
        static let horizontalCellHeight: CGFloat = 100.0
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel: ListViewModelInterface!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListCollectionViewCell.defaultNib,
                                forCellWithReuseIdentifier: ListCollectionViewCell.cellIdentifier)

        collectionView.register(ListFooterView.defaultNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ListFooterView.identifier)
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

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
            let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ListFooterView.identifier,
                for: indexPath)

            setup(footerView as? ListFooterView)

            return footerView
        }
        fatalError()
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width
        return CGSize(width: width, height: Constant.horizontalCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {

        let width = collectionView.frame.width
        return CGSize(width: width, height: Constant.buttonHeight)
    }
}

private extension ListViewController {
    func setup(_ footerView: ListFooterView?) {
        // TODO: Localize
        footerView?.title = "Load More"
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(loadMoreButtonTapped))
        footerView?.addGestureRecognizer(gestureRecognizer)
    }

    @objc
    func loadMoreButtonTapped() {
        viewModel.loadMovies()
    }
}

extension ListViewController: NibLoadable { }
