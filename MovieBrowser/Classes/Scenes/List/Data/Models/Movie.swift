//
//  Movie.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class Movie: Decodable {

    private enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
    }

    let title: String?

    let posterPath: String?
}
