//
//  ListViewModel.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation

final class ListViewModel: ListViewModelInterface {

    var stateChangeHandler: ((ListState.Change) -> Void)?

    private var state = ListState()
}
