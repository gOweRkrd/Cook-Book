//
//  AppDelegate.swift
//  CookBook
//
//  Created by Дария Григорьева on 27.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var favoriteRecipes: [CuisineRecipe] = []
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // add sleep to show launch screen
        Thread.sleep(forTimeInterval: 3.0)
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = FirstScreenViewController()
        let navController = UINavigationController (rootViewController: viewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
