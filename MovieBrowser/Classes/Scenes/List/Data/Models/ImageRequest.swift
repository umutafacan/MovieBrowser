//
//  ImageRequest.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

struct ImageRequest: Request {

    private enum Constant {
        static let sizePrefix = "w200"
    }

    var endpoint: String

    var method: HTTPMethod = .get

    init(path: String) {
        self.endpoint = [Constant.sizePrefix, path].joined()
    }
}
