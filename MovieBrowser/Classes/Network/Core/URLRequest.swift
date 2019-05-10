//
//  URLRequest.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

extension URLRequest {
    static func requestWithURL(url: URL,
                               method: HTTPMethod,
                               queryParameters: StringDictionary?,
                               bodyParameters: JSONDictionary?,
                               headers: StringDictionary?) -> URLRequest {
        // Append querystring to URL
        var actualURL = url
        if let queryParameters = queryParameters,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            components.queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            if let componentsURL = components.url {
                actualURL = componentsURL
            }
        }

        var request = URLRequest(url: actualURL)
        request.httpMethod = method.rawValue

        // Add any body JSON parameters for POST requests
        if let bodyParameters = bodyParameters {
            request.setValue(HTTPHeader.Value.ContentType.json,
                             forHTTPHeaderField: HTTPHeader.Key.contentType)
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
        }

        // Add extra headers
        headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }

        return request
    }
}
