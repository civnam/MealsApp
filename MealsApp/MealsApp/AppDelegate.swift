//
//  AppDelegate.swift
//  MealsApp
//
//  Created by Isaac Dimas on 02/10/23.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let viewModel = MealsViewModel()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mealsVC = MealsViewController()
        let dashboardNavCtr = UINavigationController()
        
        let searchNavCtr = UINavigationController()
        
        let searchView = ContentView(viewModel: self.viewModel)
        let searchVC = UIHostingController(rootView: searchView)
        searchVC.view.backgroundColor = .clear
        searchVC.modalPresentationStyle = .fullScreen
        
        dashboardNavCtr.pushViewController(mealsVC, animated: true)
        searchNavCtr.pushViewController(searchVC, animated: true)
        
        let tabBarController = MainTabBarViewController(dashboardViewController: dashboardNavCtr,
                                                        secondViewController: searchVC,
                                                        thirdViewController: ThirdViewController()
        )

        tabBarController.selectedIndex = 1
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//

}

