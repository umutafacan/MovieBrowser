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

    private var imageSessionManager: URLSessionManager

    private init() {
        guard let url = URL(string: APIConstants.baseURL) else {
            fatalError("Base url is not valid!")
        }
        let parameters = [RequestParameter.Key.apiKey: APIConstants.apiKey]
        let sessionConfiguration = SessionConfiguration(baseURL: url, queryParameters: parameters)
        self.urlSessionManager = URLSessionManager(sessionConfiguration: sessionConfiguration)

        guard let imageURL = URL(string: APIConstants.imageURL) else {
            fatalError("Image url is not valid!")
        }

        let imageSessionConfiguration = SessionConfiguration(baseURL: imageURL)
        self.imageSessionManager = URLSessionManager(sessionConfiguration: imageSessionConfiguration)
    }

    func send(request: Request, completion: @escaping NetworkCompletion) {
        urlSessionManager.send(request: request) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }

    func send(imageRequest: ImageRequest, completion: @escaping NetworkCompletion) -> URLSessionTask? {
        return imageSessionManager.send(request: imageRequest, completion: completion)
    }
}
