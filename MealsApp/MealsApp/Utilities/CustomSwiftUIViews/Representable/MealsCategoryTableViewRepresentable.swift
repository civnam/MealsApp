//
//  MealsCategoryTableViewRepresentable.swift
//  MealsApp
//
//  Created by Isaac Dimas on 03/10/23.
//

import Foundation
import SwiftUI

struct MealsCategoryTableViewRepresentable: UIViewControllerRepresentable {

    var category: String
    var completion: Completion

    func makeUIViewController(context: Context) -> some UIViewController {
        
        let mealCategory = MealsCategory(rawValue: category)
        let mealsCategoryTblVwCtlr = MealsCategoryTableViewController()
        mealsCategoryTblVwCtlr.mealCategory = mealCategory
        mealsCategoryTblVwCtlr.completion = self.completion
        return mealsCategoryTblVwCtlr
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
