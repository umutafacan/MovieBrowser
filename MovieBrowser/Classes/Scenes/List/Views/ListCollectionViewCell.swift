//
//  ListCollectionViewCell.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation
import UIKit

final class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoriteImageView: UIImageView!
    static let cellIdentifier = "ListCollectionViewCell"

    @IBOutlet private weak var imageView: ImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var imagePath: String? {
        didSet {
            imageView.imagePath = imagePath
        }
    }

    var isFavorite: Bool = false {
        didSet {
            favoriteImageView.image = isFavorite ? UIImage(named: "favorite_star") : nil
        }
    }

    var style: ListViewController.Layout = .list {
        didSet {
            switch style {
            case .list:
                titleLabel.textAlignment = .natural
            case .grid:
                titleLabel.textAlignment = .center
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        titleLabel.backgroundColor = UIColor(white: 0, alpha: 0.4)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        imageView.contentMode = .scaleAspectFill
    }
}

extension ListCollectionViewCell: NibLoadable { }
