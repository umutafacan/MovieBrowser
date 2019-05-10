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

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
}
