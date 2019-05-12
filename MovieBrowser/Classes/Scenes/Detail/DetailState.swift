//
//  DetailState.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

typealias MovieInfo = (title: String?, description: String?)
typealias VoteInfo = (avarage: Float, count: Int)

final class DetailState {

    enum Change {
        case loading(Bool)
        case imageSource(String?)
        case movieInfo(MovieInfo?)
        case vote(VoteInfo?)
        case favorite(Bool)
    }

    var onChange: ((Change) -> Void)?

    var isLoading = false {
        didSet {
            onChange?(.loading(isLoading))
        }
    }

    var imageSource: String? {
        didSet {
            onChange?(.imageSource(imageSource))
        }
    }

    var movieInfo: MovieInfo? {
        didSet {
            onChange?(.movieInfo(movieInfo))
        }
    }

    var vote: VoteInfo? {
        didSet {
            onChange?(.vote(vote))
        }
    }

    var isFavorite: Bool = false {
        didSet {
            onChange?(.favorite(isFavorite))
        }
    }
}
