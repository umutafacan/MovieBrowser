//
//  MovieListRequest.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class MovieListRequest: Request {

    let endpoint: String = "movie/popular"

    let method: HTTPMethod = .get

    let queryParameters: StringDictionary?

    init(page: Int) {
        self.queryParameters = [
            RequestParameter.Key.language: RequestParameter.Value.english,
            RequestParameter.Key.page: "\(page)"
        ]
    }
}
