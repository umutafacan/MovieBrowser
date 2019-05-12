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
        static let path = "favorites.archive"
    }

    static let shared = FavoriteStorage()

    private init() {
        load()
    }

    var favorites: [Int: Bool] = [:]
}

extension FavoriteStorage {
    func store() {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: favorites, requiringSecureCoding: true) else {
            print("Error while achiving data!")
            return
        }

        do {
            try data.write(to: URL(fileURLWithPath: filePath(key: Constant.path)))
        } catch {
            print("Error while writing data!")
        }
    }

    private func load() {

        if let nsData = NSData(contentsOfFile: filePath(key: Constant.path)) {
            do {
                let data = Data(referencing:nsData)
                self.favorites = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Int: Bool] ?? [:]
            }
            catch {
                print("Error while reading!")
            }
        }
    }

    private func filePath(key:String) -> String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent(key).path)
    }
}
