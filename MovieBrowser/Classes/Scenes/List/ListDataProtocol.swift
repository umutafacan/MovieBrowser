//
//  ListDataProtocol.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

typealias FetchMoviesCompletion = ((MovieListResponse?, Error?) -> Void)

protocol ListDataProtocol {

    func fetchMovies(page: Int, completion: @escaping FetchMoviesCompletion)
}
