//
//  MealDetailViewRepresentable.swift
//  MealsApp
//
//  Created by Isaac Dimas on 03/10/23.
//

import Foundation
import SwiftUI

struct MealDetailViewRepresentable: UIViewControllerRepresentable {
    
    var idMeal: String
    var calendarEntryPoint = false
    var completion: Completion?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let mealDetailVC = MealDetailViewController()
        mealDetailVC.idMeal = self.idMeal
        mealDetailVC.calendarEntryPoint = self.calendarEntryPoint
        mealDetailVC.completion = self.completion
        return mealDetailVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
