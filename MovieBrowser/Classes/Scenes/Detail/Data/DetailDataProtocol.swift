//
//  DetailDataProtocol.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

typealias FetchDetailCompletion = ((MovieDetail?, Error?) -> Void)

protocol DetailDataProtocol {
    
    func fetchMovieDetail(identifier: Int, completion: @escaping FetchDetailCompletion)
}
