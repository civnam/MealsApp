//
//  MealsPresenter.swift
//  MealsApp
//
//  Created by Isaac Dimas on 30/09/23.
//

import Foundation


final class MealsPresenter {
    
    // MARK: - Delegates
    weak private var mealsViewDelegate: MealsViewDelegate?
    //weak private var coordinatorDelegate: MainCoordinator?
    
    // MARK: - Atributes
    private var mealsApiService: MealsAPI
    private var meals = [Meal]()
    private var mealDetail: MealDetail?
    private var mealsCategory = [MealsCategory]()
    private var mealIngredients: [String?]?
    private var mealMeasures: [String?]?
    
    // MARK: - Init of class
    init(mealsApiService: MealsAPI) {
        self.mealsApiService = mealsApiService
    }
    
    // MARK: - Methods
    func setMealsDelegate(mealsViewDelegate: MealsViewDelegate) {
        self.mealsViewDelegate = mealsViewDelegate
    }
    
    func getTotalMeals() -> Int {
        return meals.count
    }
    
    func getMeal(indexPath: Int) -> Meal {
        return meals[indexPath]
    }
    
    func getAllMeals(category: MealsCategory = .dessert) {
        
        self.mealsApiService.getMealsFromAPI(category: category, completion: { [weak self] meals in
            guard let meals = meals else {
                return
            }
            self?.meals = meals
            self?.mealsViewDelegate?.refreshMealsData()
        })
    }
    
    func getTotalCategories() -> Int {
        let mealsCategories = MealsCategory.allCases.count
        return mealsCategories
    }
    
    func getAllCategories() {
        let categories = MealsCategory.allCases
        mealsCategory = categories
    }
    
    func getCategory(indexPath: Int) -> MealsCategory {
        return mealsCategory[indexPath]
    }
    
    func setMealDetail(idMeal: String) {
        
        self.mealsApiService.getMealDetailFromAPI(idMeal: idMeal) { mealDetail in
            self.mealDetail = mealDetail
            self.mealIngredients = self.mealDetail?.arrIngredients
            self.mealMeasures = self.mealDetail?.arrMeasures
            self.mealsViewDelegate?.refreshMealsData()
        }
    }
    
    func getMealDetail() -> MealDetail? {
        return mealDetail
    }
    
    func getMealTotalIngredients() -> Int? {
        return mealDetail?.arrIngredients.count
    }
    
    func getMealIngredient(indexPath: Int) -> String? {
        let ingredient = mealIngredients?[indexPath]
        return ingredient
    }
    
    func getMealMeasure(indexPath: Int) -> String? {
        let measure = mealMeasures?[indexPath]
        return measure
    }
}
