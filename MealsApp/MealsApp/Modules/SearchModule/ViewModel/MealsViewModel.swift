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
    @Published var callFromApiIsLoading: Bool = true
    
    private var mealsApiService: MealsAPI = MealsAPI()
    
    func getMeals(category: MealsCategory) {
        mealsApiService.getMealsFromAPI(category: category, completion: { meals in
            DispatchQueue.main.async {
                self.meals = meals ?? []
                self.callFromApiIsLoading = false
            }
        })
    }
    
    func getStr() {
        print("XXX", selection)
    }
}
