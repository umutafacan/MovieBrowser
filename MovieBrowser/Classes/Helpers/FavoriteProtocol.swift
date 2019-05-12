//
//  FavoriteProtocol.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 12/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

protocol FavoriteProtocol {

    var identifier: Int  { get }
    var isFavorite: Bool { get set }
}

extension FavoriteProtocol {

    var isFavorite: Bool {
        get {
            return FavoriteStorage.shared.favorites[identifier] ?? false
        }
        set {
            FavoriteStorage.shared.favorites[identifier] = newValue
        }
    }
}
