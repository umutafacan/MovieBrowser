//
//  Storage.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 12/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class FavoriteStorage {

    private enum Constant {
        static let path = "/backup/favorites"
    }

    static let shared = FavoriteStorage()

    private init() {
        load()
    }

    var favorites: [Int: Bool] = [:]
}

extension FavoriteStorage {
    func store() {
        NSKeyedArchiver.archiveRootObject(favorites, toFile: Constant.path)
    }

    private func load() {
        guard let favorites = NSKeyedUnarchiver.unarchiveObject(withFile: Constant.path) as? [Int: Bool] else {
            return
        }
        self.favorites = favorites
    }
}
