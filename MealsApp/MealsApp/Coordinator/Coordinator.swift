//
//  Coordinator.swift
//  MealsApp
//
//  Created by Isaac Dimas on 03/10/23.
//

import Foundation
import UIKit
import SwiftUI

protocol CoordinatorDelegate {
    func initApp()
    func dismissView(animated: Bool)
}

final class Coordinator: CoordinatorDelegate {
    
    // MARK: - Atributes
    @State private var eventManager: EventManager
    private var firstTimeUserApp: Bool = true
    private var completion: Callback?
    private let viewModel = MealsViewModel()
    
    private var introLottieViewController: IntroLottieViewController?
    private var mainTabBarController: MainTabBarViewController?
    private let navigationController: UINavigationController
    private var newsNavigationController: UINavigationController?
    private var usersNavigationController: UINavigationController?
    
    // MARK: - Init of class
    init(navigationController: UINavigationController, eventManager: EventManager) {
        self.navigationController = navigationController
        self.eventManager = eventManager
    }
    
    // MARK: - Methods
    
    func initApp() {
        self.pushIntroLottieViewController()
    }
    
    private func pushIntroLottieViewController() {
        
        self.introLottieViewController = IntroLottieViewController(completion: { _ in
            
            self.initNavigationApp()
        })
        self.introLottieViewController?.coordinatorDelegate = self
        self.navigationController.pushViewController(self.introLottieViewController ?? UIViewController(), animated: true)
    }

    private func initNavigationApp() {

        let firstTimeKey = UserDefaults.standard.dictionaryRepresentation().keys.contains("isFirstTimeUserApp")
        if firstTimeKey {
            self.firstTimeUserApp = UserDefaults.standard.object(forKey: "isFirstTimeUserApp") as? Bool ?? false
        }
        
        self.completion = { _ in
            self.dismissView(animated: false)
            self.goToDashboard()
        }
        
        if firstTimeUserApp {
            let introCardsVC = getIntroSlidingCardsView()
            introCardsVC.modalPresentationStyle = .fullScreen
            introCardsVC.modalTransitionStyle = .crossDissolve
            self.navigationController.present(introCardsVC, animated: true)
        } else {
            
            goToDashboard()
        }
    }
    
    func dismissView(animated: Bool = true) {
        self.navigationController.dismiss(animated: true)
    }
    
    private func goToDashboard() {
        
        self.pushMainTabBarViewController()
    }
    
    func pushMainTabBarViewController() {
        
        self.mainTabBarController = setupTabBarController()
        self.mainTabBarController?.modalPresentationStyle = .fullScreen
        self.mainTabBarController?.modalTransitionStyle = .crossDissolve
        self.navigationController.present(self.mainTabBarController ?? UIViewController(), animated: true)
    }
    
    private func setupTabBarController() -> MainTabBarViewController {
        
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
