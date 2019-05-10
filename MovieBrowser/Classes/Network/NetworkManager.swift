//
//  NetworkManager.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class NetworkManager {

    static let shared = NetworkManager()

    private var urlSessionManager: URLSessionManager

    private init() {
        guard let url = URL(string: APIConstants.baseURL) else {
            fatalError("Base url is not valid!")
        }
        let headers = [RequestParameter.Key.apiKey: APIConstants.apiKey]
        let sessionConfiguration = SessionConfiguration(baseURL: url, queryParameters: headers)
        self.urlSessionManager = URLSessionManager(sessionConfiguration: sessionConfiguration)
    }

    func send(request: Request, completion: @escaping NetworkCompletion) {
        urlSessionManager.send(request: request, completion: completion)
    }
}
