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
    @State private var eventManager = EventManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let tabBarController = setupTabBarController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    private func setupTabBarController() -> MainTabBarViewController{
        
        let dashboardNavCtr = UINavigationController()
        let mealsVC = MealsViewController()
        
        let searchView = SearchView(viewModel: self.viewModel)
        let searchVC = UIHostingController(rootView: searchView)
        searchVC.view.backgroundColor = .clear
        searchVC.modalPresentationStyle = .fullScreen
        
        let calendarView = EventsCalendarView().environmentObject(eventManager)
        let calendarVC = UIHostingController(rootView: calendarView)
        calendarVC.view.backgroundColor = .clear
        calendarVC.modalPresentationStyle = .fullScreen
        
        dashboardNavCtr.pushViewController(mealsVC, animated: true)
        
        let tabBarController = MainTabBarViewController(dashboardViewController: dashboardNavCtr,
                                                        searchViewController: searchVC,
                                                        calendarViewController: calendarVC)
        tabBarController.selectedIndex = 1
        return tabBarController
    }
}

