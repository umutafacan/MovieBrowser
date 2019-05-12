//
//  ListViewModel.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class ListViewModel: ListViewModelInterface {

    var stateChangeHandler: ((ListState.Change) -> Void)? {
        get {
            return state.onChange
        }

        set {
            state.onChange = newValue
        }
    }

    private var movies: [Movie] = []

    var filteredMovies: [Movie] = []

    private var filterKeyword: String?

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

        dataController?.fetchMovies(page: latestFetchedPage + 1,
                                    completion: { [weak self] (response, error) in
            guard let strongSelf = self else {
                return
            }

            strongSelf.state.isLoading = false

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

            strongSelf.filter(by: strongSelf.filterKeyword)
        })
    }

    func filter(by keyword: String?) {
        filterKeyword = keyword
        guard let keyword = keyword,
            !keyword.isEmpty else {
            filteredMovies = movies
            state.onChange?(.movies)
            return
        }

        filteredMovies = movies.filter({ (movie) -> Bool in
            return movie.title?.contains(keyword) ?? false
        })

        state.onChange?(.movies)
    }
}
