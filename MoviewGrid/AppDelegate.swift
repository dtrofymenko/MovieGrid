//
//  AppDelegate.swift
//  MoviewGrid
//
//  Created by Dmytro Trofymenko on 6/9/19.
//  Copyright © 2019 Dmytro Trofymenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flowCoordinator: FlowCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupUI()

        return true
    }

    // MARK: - Private
    private func setupUI() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.tintColor,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0, weight: .regular)]
        navigationController.navigationBar.tintColor = .tintColor

        let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window

        flowCoordinator = FlowCoordinator(navigationController: navigationController)
        flowCoordinator?.start()
    }
}
