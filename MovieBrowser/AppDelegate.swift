//
//  AppDelegate.swift
//  MovieBrowser
//
//  Created by Umut Afacan on 09/05/2019.
//  Copyright © 2019 umutafacan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var rootController: UINavigationController? {
        return self.window?.rootViewController as? UINavigationController
    }

    private lazy var applicationCoordinator: Coordinator? = makeCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = UINavigationController()
        self.window?.makeKeyAndVisible()

        applicationCoordinator?.start()

        return true
    }

    private func makeCoordinator() -> Coordinator? {
        guard let rootController = rootController else {
            return nil
        }
        return ApplicationCoordinator(navigationController: rootController)
    }
}
