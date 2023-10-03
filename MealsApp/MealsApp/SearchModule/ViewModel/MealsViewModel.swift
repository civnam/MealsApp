//
//  MealsViewModel.swift
//  SearchView
//
//  Created by Isaac Dimas on 01/10/23.
//

import Foundation

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selection: Int = 0
    
    private var mealsApiService: MealsAPI = MealsAPI()
    
    func getMeals(category: MealsCategory) {
        mealsApiService.getMealsFromAPI(category: category, completion: { meals in
            DispatchQueue.main.async {
                self.meals = meals ?? []
            }
        })
    }
    
    func getStr() {
        print("XXX", selection)
    }
}
