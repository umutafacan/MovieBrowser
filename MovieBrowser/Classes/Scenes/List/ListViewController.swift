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
        collectionView.register(ListCollectionViewCell.self,
                                forCellWithReuseIdentifier: ListCollectionViewCell.cellIdentifier)
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1 // TODO: will be implemented
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCollectionViewCell.cellIdentifier,
            for: indexPath) as? ListCollectionViewCell else {
            return UICollectionViewCell(frame: .zero)
        }

        // TODO: To be implemeted

        return cell
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: To be implemeted
        let height = 50.0
        let width = 100.0
        return CGSize(width: width, height: height)
    }
}

extension ListViewController: NibLoadable { }
