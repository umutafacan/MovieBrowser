//
//  ListDataController.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class ListDataController: ListDataProtocol {
    func fetchMovies(page: Int, completion: @escaping FetchMoviesCompletion) {

        let request = MovieListRequest(page: page)
        NetworkManager.shared.send(request: request) { result in
            let response = MovieListResponse.model(withJSONData: result.data)

            completion(response,result.error)
        }
    }
}
