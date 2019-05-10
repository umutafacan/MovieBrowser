//
//  Request.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

protocol Request {

    /// Endpoint string
    var endpoint: String { get }

    /// HTTP method
    var method: HTTPMethod { get }

    /// Query parameters appear at the end of the request URL after a question mark (?), with
    /// different name=value pairs separated by ampersands (&), .e.g. /users?role=admin
    var queryParameters: StringDictionary? { get }

    /// Body parameters that describe the body of POST, PUT and PATCH requests
    var bodyParameters: JSONDictionary? { get }
}

extension Request {
    
    var queryParameters: StringDictionary? {
        return nil
    }

    var bodyParameters: JSONDictionary? {
        return nil
    }
}
