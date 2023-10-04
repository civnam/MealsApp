//
//  MealsCategory.swift
//  MealsApp
//
//  Created by Isaac Dimas on 01/10/23.
//

import Foundation

// MARK: - Meals Category Model From API

struct MealsCategoryModelAPI {
    let strCategory: String
}

// MARK: - Meals Category Model
public enum MealsCategory: String, CaseIterable {

    case beef
    case breakfast
    case chicken
    case dessert
    case goat
    case lamb
    case miscellaneous
    case pasta
    case pork
    case seafood
    case side
    case vegan
    case vegetarian
    
    var categoryName: String {
        switch self {
        
        case .beef:
            return "Beef"
        case .breakfast:
            return "Breakfast"
        case .chicken:
            return "Chicken"
        case .dessert:
            return "Dessert"
        case .goat:
            return "Goat"
        case .lamb:
            return "Lamb"
        case .miscellaneous:
            return "Miscellaneous"
        case .pasta:
            return "Pasta"
        case .pork:
            return "Pork"
        case .seafood:
            return "Seafood"
        case .side:
            return "Side"
        case .vegan:
            return "Vegan"
        case .vegetarian:
            return "Vegetarian"
        }
    }
}
