//
//  Response.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

/// URL response wrapper
struct Response {
    /// Data returned by the server
    let data: Data?

    /// HTTP status code of the receiver
    let statusCode: Int?

    /// Dictionary containing all the HTTP header fields of the receiver
    let allHeaderFields: [AnyHashable: Any]?

    /// HTTP error received by the response
    let error: Error?

    // MARK: - Helpers

    var responseJSON: JSONDictionary? {
        if let data = data,
            let responseJSON = try? JSONSerialization.jsonObject(with: data) {
            return responseJSON as? JSONDictionary
        } else {
            return nil
        }
    }

    var responseString: String? {
        if let data = data {
            return String(data: data, encoding: String.Encoding.utf8)
        } else {
            return nil
        }
    }
}
