//
//  ImageLoader.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

typealias ImageCompletion = ((UIImage?) -> Void)

final class ImageLoader {

    private var task: URLSessionTask?

    func loadImage(path: String, completion: @escaping ImageCompletion) {
        task?.cancel()

        let request = ImageRequest(path: path)
        task = NetworkManager.shared.send(imageRequest: request) { response in
            DispatchQueue.main.async {
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                let image = UIImage(data: data)
                completion(image)
            }
        }
    }
}
