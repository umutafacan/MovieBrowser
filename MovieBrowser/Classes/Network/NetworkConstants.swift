//
//  NetworkConstants.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

// MARK: - Typealiases

typealias JSONDictionary = [String: Any]
typealias StringDictionary = [String: String]
typealias NetworkCompletion = (Response) -> Void

enum HTTPHeader {
    enum Key {
        static let contentType = "Content-Type"
    }

    enum Value {
        enum ContentType {
            static let json = "application/json"
            static let urlEncoded = "application/x-www-form-urlencoded; charset=utf-8"
            static let plist = "application/x-plist"
        }
    }
}

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}
