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
    
    @State private var eventManager = EventManager()
    var coordinator: Coordinator?
    var navigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.coordinator = Coordinator(navigationController: self.navigationController, eventManager: self.eventManager)
        self.coordinator?.initApp()
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

