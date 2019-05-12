//
//  DetailViewModel.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class DetailViewModel {

    var stateChangeHandler: ((DetailState.Change) -> Void)? {
        get {
            return state.onChange
        }

        set {
            state.onChange = newValue
        }
    }

    private let state = DetailState()

    private let dataController: DetailDataProtocol
    private let movieId: Int

    init(dataController: DetailDataProtocol, movieId: Int) {
        self.dataController = dataController
        self.movieId = movieId
    }

    func loadPage() {
        state.isLoading = true
        dataController.fetchMovieDetail(identifier: movieId) { [weak self] response, error in
            guard let strongSelf = self else {
                return
            }
            strongSelf.state.isLoading = false

            strongSelf.state.imageSource = response?.posterPath
            strongSelf.state.movieInfo = MovieInfo(title: response?.title,
                                                   description: response?.description)
            guard let avarage = response?.voteAvarage,
                let count = response?.voteCount else {
                    return
            }
            strongSelf.state.vote = VoteInfo(avarage: avarage, count: count)
        }
    }
}
