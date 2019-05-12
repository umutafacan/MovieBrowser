//
//  MovieDetail.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

struct MovieDetail: Decodable {

    private enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case description = "overview"
        case voteCount = "vote_count"
        case voteAvarage = "vote_average"
        case identifier = "id"
    }

    let title: String
    let posterPath: String
    let description: String
    let voteCount: Int
    let voteAvarage: Float
    let identifier: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        description = try container.decode(String.self, forKey: .description)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        voteAvarage = try container.decode(Float.self, forKey: .voteAvarage)
        identifier = try container.decode(Int.self, forKey: .identifier)
    }

    var isFavorite: Bool {
        get {
            return FavoriteStorage.shared.favorites[identifier] ?? false
        }
        set {
            FavoriteStorage.shared.favorites[identifier] = newValue
        }
    }
}
