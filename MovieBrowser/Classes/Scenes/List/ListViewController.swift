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
        static let listCellHeight: CGFloat = 100.0
        static let gridCellHeight: CGFloat = 200.0
        static let cellSpacing: CGFloat = 10.0
    }

    enum Layout {
        case list
        case grid
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    /// Closure for detail show request
    var onDetail: ((Int) -> Void)?

    var viewModel: ListViewModelInterface!

    private var layout: Layout = .grid {
        didSet {
            configureLayoutButton(layout: layout)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListCollectionViewCell.defaultNib,
                                forCellWithReuseIdentifier: ListCollectionViewCell.cellIdentifier)

        collectionView.register(ListFooterView.defaultNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ListFooterView.identifier)
        addChangeObserver()

        configureNavigationBar()

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
            toggleIndicatingActivity(isLoading)
        case .movies:
            collectionView.reloadData()
        }
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredMovies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCollectionViewCell.cellIdentifier,
            for: indexPath) as? ListCollectionViewCell else {
                return UICollectionViewCell(frame: .zero)
        }

        let movie = viewModel.filteredMovies[indexPath.item]
        cell.title = movie.title
        cell.imagePath = movie.posterPath
        cell.style = layout

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

        var width: CGFloat
        var height: CGFloat

        switch layout {
        case .list:
            width = collectionView.frame.width
            height = Constant.listCellHeight
        case .grid:
            width = (collectionView.frame.width - Constant.cellSpacing) / 2
            height = Constant.gridCellHeight
        }

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {

        let width = collectionView.frame.width
        return CGSize(width: width, height: Constant.buttonHeight)
    }
}

extension ListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let movieId = viewModel.filteredMovies[indexPath.item].identifier
        onDetail?(movieId)
    }
}

extension ListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
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

    func configureLayoutButton(layout: Layout) {
        var image: UIImage?

        switch layout {
        case .list:
            image = UIImage(named: "grid")
        case .grid:
            image = UIImage(named: "list")
        }

        let button = UIBarButtonItem(image: image,
                                     style: .plain,
                                     target: self,
                                     action: #selector(toggleLayout))

        navigationItem.setRightBarButton(button, animated: true)
    }

    @objc
    func toggleLayout() {
        switch layout {
        case .grid:
            layout = .list
        case .list:
            layout = .grid
        }
        collectionView.collectionViewLayout.invalidateLayout()
    }

    func configureNavigationBar() {
        configureLayoutButton(layout: layout)
        // TODO: Localize
        navigationItem.title = "Movies List"
    }
}

extension ListViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filter(by: nil)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(by: searchText)
    }
}

extension ListViewController: NibLoadable { }
