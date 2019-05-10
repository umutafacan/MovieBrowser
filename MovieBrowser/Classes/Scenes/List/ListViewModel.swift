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

    var movies: [Movie] = []

    private var latestFetchedPage = 0
    private var totalPages: Int?

    private var state = ListState()

    private var dataController: ListDataProtocol?

    init(dataController: ListDataProtocol) {
        self.dataController = dataController
    }

    func loadMovies() {

        guard latestFetchedPage < totalPages ?? Int.max else {
            // TODO: no more content error
            return
        }

        state.isLoading = true

        dataController?.fetchMovies(page: latestFetchedPage + 1, completion: { [weak self] (response, error) in
            guard let strongSelf = self else {
                return
            }

            strongSelf.state.isLoading = true

            guard error == nil else {
                // handle error
                return
            }
            guard let response = response,
            let movies = response.movies else {
                return
            }

            strongSelf.movies.append(contentsOf: movies)
            strongSelf.latestFetchedPage += 1
            strongSelf.totalPages = response.totalPages
        })
    }
}
