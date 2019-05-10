//
//  ViewController.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 09/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel: ListViewModelInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ListViewController: NibLoadable { }
