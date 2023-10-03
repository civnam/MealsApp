//
//  ContentView.swift
//  SearchView
//
//  Created by Isaac Dimas on 01/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var categorySelected: String = "Click Here"
    @State var search = ""
    @StateObject var viewModel: MealsViewModel
    
    var categories: [MealsCategory] = MealsCategory.allCases
    
    var body: some View {
        
        NavigationStack {

            VStack {
                List {
                    Section {
                        ForEach(viewModel.meals.filter{
                            let mealName = $0.strMeal ?? ""
                            return search.isEmpty ? true : mealName.contains(search)
                        })
                        { meal in
                            MealSearchCell(meal: meal)
                                .cornerRadius(15)
                                .padding(5)
                                .shadow(color: .customWhite1, radius: 10)
                        }.listRowBackground(Color.customYellow2)
                    }
                }
                .padding(.top)
                .shadow(color: Color.customWhite1, radius: 10)
                .scrollContentBackground(.hidden)
            }
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
            .toolbar {
                Menu {
                    ForEach(0 ..< categories.count, id: \.self) {
                        let category = categories[$0]
                        Button(category.categoryName, action: {
                            categorySelected = category.categoryName
                            viewModel.getMeals(category: category)
                        })
                    }
                } label: {
                    Text(categorySelected)
                }
            }
            .padding(.top, -35)
            .navigationTitle("Search More")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(Color.customBlue1.ignoresSafeArea())
        }
        .onAppear {
            viewModel.getMeals(category: .beef)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MealsViewModel())
    }
}
