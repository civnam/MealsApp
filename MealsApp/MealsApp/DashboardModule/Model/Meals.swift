//
//  Meals.swift
//  MealsApp
//
//  Created by Isaac Dimas on 30/09/23.
//

import Foundation

// MARK: - Meals APIResponse Model
struct MealsAPIResponse: Decodable {
    let meals: [Meal]
}

// MARK: - Meals Model
struct Meal: Decodable, Identifiable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
    public var id: String {
        self.idMeal ?? ""
    }
}
