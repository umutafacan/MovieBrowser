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

    private var movieDetail: MovieDetail?

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

            strongSelf.movieDetail = response

            strongSelf.state.imageSource = strongSelf.movieDetail?.posterPath
            strongSelf.state.movieInfo = MovieInfo(title: strongSelf.movieDetail?.title,
                                                   description: strongSelf.movieDetail?.description)
            guard let movieDetail = strongSelf.movieDetail else {
                return
            }
            strongSelf.state.vote = VoteInfo(avarage: movieDetail.voteAvarage, count: movieDetail.voteCount)

            strongSelf.state.isFavorite = movieDetail.isFavorite
        }
    }

    func toggleFavoriteOption() {
        movieDetail?.isFavorite = !state.isFavorite
        state.isFavorite = movieDetail?.isFavorite ?? false
    }
}
