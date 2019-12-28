//
//  AppDelegate.swift
//  segmented-feed
//
//  Created by Boyan Yankov on 2019-W52-25-Dec-Wed.
//  Copyright © 2019 boyankov@yahoo.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    var window: UIWindow?
    private let rootDependencyContainer = RootDependencyContainerImpl()

    // MARK: - UIApplicationDelegate protocol
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let vc: RootViewController = self.rootDependencyContainer.makeRootViewController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        return true
    }
}
