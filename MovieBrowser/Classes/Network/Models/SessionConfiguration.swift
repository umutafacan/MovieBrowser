//
//  SessionConfiguration.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class SessionConfiguration {
    /// Base URL
    var baseURL: URL

    /// Components of the header section of request and response messages in HTTP
    var headers: StringDictionary?

    var queryParameters: StringDictionary?

    init(baseURL: URL, headers: StringDictionary? = nil, queryParameters: StringDictionary? = nil) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
