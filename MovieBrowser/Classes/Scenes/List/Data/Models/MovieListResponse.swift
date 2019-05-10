//
//  MovieListResponse.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class MovieListResponse: Decodable {

    private enum CodingKeys: String, CodingKey {

        case page
        case totalPages = "total_pages"
        case results
    }

    let page: Int

    let totalPages: Int

    let movies: [Movie]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        movies = try container.decode([Movie].self, forKey: .results)
    }
}
