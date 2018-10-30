//
//  AppDelegate.swift
//  noteApp
//
//  Created by Marcel Harvan on 2018-10-28.
//  Copyright © 2018 Marcel Harvan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Setting root controller
        window = UIWindow()
        window?.makeKeyAndVisible()
        let navController = UINavigationController(rootViewController: MineVC())
        // setting color for NavBar
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = .yellowNavBar
        navController.navigationBar.tintColor = .black

        window?.rootViewController = navController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

