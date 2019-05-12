//
//  ListViewModelInterface.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

protocol ListViewModelInterface {

    var stateChangeHandler: ((ListState.Change) -> Void)?  { get set }

    var filteredMovies: [Movie] { get }

    func loadMovies()

    func filter(by keyword: String?) 
}
