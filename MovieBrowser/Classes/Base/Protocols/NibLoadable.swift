//
//  NibLoadable.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

public protocol NibLoadable {

    /// Default nib name.
    static var defaultNibName: String { get }

    /// Default nib created using nib name and bundle.
    static var defaultNib: UINib { get }

    /// Loads view from the default nib.
    ///
    /// - Returns: Loaded view.
    static func loadFromNib() -> Self
}

public extension NibLoadable {

    static var defaultNibName: String {
        return String(describing: self)
    }

    static var defaultNib: UINib {
        return UINib(nibName: defaultNibName, bundle: Bundle.main)
    }

    static func loadFromNib() -> Self {
        guard let result = Bundle.main.loadNibNamed(defaultNibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("[NibLoadable] Cannot load view from nib.")
        }
        return result
    }
}

extension NibLoadable where Self: UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: Bundle.main)
        }

        return instantiateFromNib()
    }
}
