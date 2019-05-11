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

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        titleLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
        titleLabel.textColor = UIColor.white
        imageView.contentMode = .scaleAspectFill
    }
}

extension ListCollectionViewCell: NibLoadable { }
