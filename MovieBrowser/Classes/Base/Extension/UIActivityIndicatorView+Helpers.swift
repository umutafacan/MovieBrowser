//
//  UIActivityIndicatorView+Helpers.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {

    public static func customIndicator(at center: CGPoint) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0,
                                                              y: 0.0,
                                                              width: 100.0,
                                                              height: 100.0))
        indicator.layer.cornerRadius = 10
        indicator.center = center
        indicator.hidesWhenStopped = true
        indicator.style = .whiteLarge
        indicator.backgroundColor = .black
        return indicator
    }
}
