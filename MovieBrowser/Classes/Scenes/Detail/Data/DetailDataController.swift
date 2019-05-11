//
//  DetailDataController.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class DetailDataController: DetailDataProtocol {

    func fetchMovieDetail(identifier: Int, completion: @escaping FetchDetailCompletion) {
        let request = MovieDetailRequest(movieId: identifier)

        NetworkManager.shared.send(request: request) { response in
            let data = MovieDetail.model(withJSONData: response.data)

            completion(data, response.error)
        }
    }
}
