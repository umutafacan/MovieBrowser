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

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0,
                                                              y: 0.0,
                                                              width: 20.0,
                                                              height: 20.0))
        indicator.hidesWhenStopped = true
        indicator.style = .gray
        indicator.backgroundColor = .clear

        return indicator
    }()

    var imagePath: String? {
        didSet {
            guard let path = imagePath else {
                return
            }
            activityIndicator.startAnimating()
            imageLoader.loadImage(path: path) { [weak self] image in
                self?.activityIndicator.stopAnimating()
                self?.image = image
            }
        }
    }

    var imageWidth: CGFloat? {
        didSet {
            guard let imageWidth = imageWidth else { return }
            imageLoader.imageWidth = Int(imageWidth)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
