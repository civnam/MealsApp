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
    private var firstTimeUserApp: Bool = true
    private var completion: Callback?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarController = setupTabBarController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let firstTimeKey = UserDefaults.standard.dictionaryRepresentation().keys.contains("isFirstTimeUserApp")
        
        if firstTimeKey {
            self.firstTimeUserApp = UserDefaults.standard.object(forKey: "isFirstTimeUserApp") as? Bool ?? false
        }
        
        self.completion = { _ in
            self.goToDashboard(tabBarController: tabBarController)
        }
        
        if firstTimeUserApp {
            let introCardsVC = getIntroSlidingCardsView()
            self.window?.rootViewController = introCardsVC
            self.window?.makeKeyAndVisible()
        } else {
            goToDashboard(tabBarController: tabBarController)
        }
        
        return true
    }
    
    private func goToDashboard(tabBarController: MainTabBarViewController) {
        
        UIView.animate(withDuration: 2, animations: {
            self.window?.rootViewController = tabBarController
            self.window?.makeKeyAndVisible()
        })
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
    
    private func getIntroSlidingCardsView() -> UIViewController {
        
        var introCardsView = IntroCardsView()
        introCardsView.completion = self.completion
        let introCardsVC = UIHostingController(rootView: introCardsView)
        introCardsVC.view.backgroundColor = .clear
        introCardsVC.modalPresentationStyle = .fullScreen
        return introCardsVC
    }
}

