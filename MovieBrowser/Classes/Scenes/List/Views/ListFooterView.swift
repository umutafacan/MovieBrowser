//
//  ListFooterView.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

final class ListFooterView: UICollectionReusableView {

    static var identifier: String {
        return "ListFooterView"
    }
    @IBOutlet private weak var titleLabel: UILabel!

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.textColor = .white
        backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
}

extension ListFooterView: NibLoadable { }
