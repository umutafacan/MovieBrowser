//
//  URLSessionManager.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

class URLSessionManager: NSObject {
    private enum ErrorConstant {
        static let httpErrorDomain = "HTTP response error"
        static let httpErrorDescriptionTitle = "HTTP response"
        static let invalidSessionConfigurationErrorMessage = "Invalid session configuration"
    }

    /// URL session
    private lazy var urlSession: URLSession = {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default,
                                    delegate: self,
                                    delegateQueue: nil)
        return urlSession
    }()

    var sessionConfiguration: SessionConfiguration

    init(sessionConfiguration: SessionConfiguration) {
        self.sessionConfiguration = sessionConfiguration

        super.init()
    }

    @discardableResult
    func send(request: Request,
              completion: @escaping NetworkCompletion) -> URLSessionTask {
        var url = sessionConfiguration.baseURL
        if let baseWithEndpoint = URL(string: request.endpoint, relativeTo: url) {
            url = baseWithEndpoint
        }

        let request = URLRequest.requestWithURL(url: url,
                                                method: request.method,
                                                queryParameters: request.queryParameters,
                                                bodyParameters: request.bodyParameters,
                                                headers: sessionConfiguration.headers)

        let task = urlSession.dataTask(with: request) { data, response, sessionError in

            var error = sessionError
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 {
                    let description = "\(ErrorConstant.httpErrorDescriptionTitle) : \(httpResponse.statusCode)"
                    error = NSError(domain: ErrorConstant.httpErrorDomain,
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: description])
                }
            }

            let httpURLResponse = response as? HTTPURLResponse
            let wrappedResponse = Response(data: data,
                                           statusCode: httpURLResponse?.statusCode,
                                           allHeaderFields: httpURLResponse?.allHeaderFields,
                                           error: error)
            completion(wrappedResponse)
        }

        task.resume()

        return task
    }
}

// MARK: - URLSessionDelegate

extension URLSessionManager: URLSessionDelegate { }
