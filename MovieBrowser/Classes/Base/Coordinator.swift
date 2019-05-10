//
//  Coordinator.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 10/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

protocol Coordinator:class {

    /// Child coordinators
    var childCoordinators: [Coordinator] { get set }

    /// Starts coordinator to activate
    func start()

    /// Adds child coordinator
    ///
    /// - Parameter coordinator: Child coordinator
    func addDependency(_ coordinator: Coordinator)

    /// Removes child coordinator
    ///
    /// - Parameter coordinator: Child coordinator
    func removeDependency(_ coordinator: Coordinator?)
}

extension Coordinator {

    func addDependency(_ coordinator: Coordinator) {
        guard childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else {
            return
        }
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

