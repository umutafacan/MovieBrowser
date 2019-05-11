//
//  ImageView.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

class ImageView: UIImageView {

    private lazy var imageLoader = ImageLoader()

    var imagePath: String? {
        didSet {
            guard let path = imagePath else {
                return
            }
            imageLoader.loadImage(path: path) { image in
                self.image = image
            }
        }
    }
}
