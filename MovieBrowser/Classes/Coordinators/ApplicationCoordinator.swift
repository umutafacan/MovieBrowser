//
//  ApplicationCoordinator.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import Foundation
import UIKit

final class ApplicationCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        runListFlow()
    }
}

private extension ApplicationCoordinator {

    func runListFlow() {
        // Initialize List View Controller
    }
}
