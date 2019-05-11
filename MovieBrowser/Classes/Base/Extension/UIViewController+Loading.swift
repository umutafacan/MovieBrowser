//
//  UIViewController+Loading.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 11/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

extension UIViewController {
    // see ObjectAssociation<T> class below
    private static let association = ObjectAssociation<UIActivityIndicatorView>()

    var indicator: UIActivityIndicatorView {
        set { UIViewController.association[self] = newValue }
        get {
            if let indicator = UIViewController.association[self] {
                return indicator
            } else {
                UIViewController.association[self]
                    = UIActivityIndicatorView.customIndicator(at: self.view.center)
                return UIViewController.association[self]!
            }
        }
    }

    // MARK: - Acitivity Indicator
    func startIndicatingActivity() {
        DispatchQueue.main.async {
            self.view.addSubview(self.indicator)
            self.indicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }

    func stopIndicatingActivity() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }

    func toggleIndicatingActivity(_ start: Bool) {
        start ? startIndicatingActivity() : stopIndicatingActivity()
    }
}
