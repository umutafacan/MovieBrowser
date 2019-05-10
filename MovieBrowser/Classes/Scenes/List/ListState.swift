//
//  ListState.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class ListState {

    enum Change {
        case loading(Bool)
    }

    var onChange: ((Change) -> Void)?

    var isLoading = false {
        didSet {
            onChange?(.loading(isLoading))
        }
    }
}
