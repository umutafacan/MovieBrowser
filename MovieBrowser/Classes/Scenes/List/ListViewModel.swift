//
//  ListViewModel.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class ListViewModel: ListViewModelInterface {

    var stateChangeHandler: ((ListState.Change) -> Void)?

    private var state = ListState()

    private var dataController: ListDataProtocol?

    init(dataController: ListDataProtocol) {
        self.dataController = dataController
    }

    func fetchMovies(at page: Int) {
        dataController?.fetchMovies(page: page, completion: { (response, error) in
            guard error == nil else {
                return
            }
            guard let response = response else {
                return
            }

            // TODO: handle response
        })
    }
}
