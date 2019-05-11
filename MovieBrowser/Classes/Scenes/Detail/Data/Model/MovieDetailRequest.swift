//
//  MovieDetailRequest.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

struct MovieDetailRequest: Request {

    var endpoint: String

    var method: HTTPMethod = .get

    init(movieId: Int) {
        self.endpoint = "movie/\(movieId)"
    }
}
