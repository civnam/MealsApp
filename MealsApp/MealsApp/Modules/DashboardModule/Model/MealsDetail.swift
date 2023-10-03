//
//  MealsDetail.swift
//  MealsApp
//
//  Created by Isaac Dimas on 01/10/23.
//

import Foundation

// MARK: - Meals Detail APIResponse Model
struct MealDetailAPIResponse: Decodable {
    let meal: [MealDetail]
}

// MARK: - Meal Detail
struct MealDetail: Decodable {
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strYoutube: String?
    let strTags: String?
    let strSource: String?
    let arrIngredients: [String?]
    let arrMeasures: [String?]
}
