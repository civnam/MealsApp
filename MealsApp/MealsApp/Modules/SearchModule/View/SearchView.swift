//
//  SearchView.swift
//  MealsApp
//
//  Created by Isaac Dimas on 01/10/23.
//

import SwiftUI

struct SearchView: View {
    
    @State var categorySelected: String = "Click Here"
    @State private var search = ""
    @StateObject var viewModel: MealsViewModel
    var categories: [MealsCategory] = MealsCategory.allCases
    var calendarEntryPoint: Bool = false
    var completion: Completion?
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                VStack {
                    List {
                        Section {
                            ForEach(viewModel.meals.filter{
                                let mealName = $0.strMeal ?? ""
                                return search.isEmpty ? true : mealName.contains(search)
                            })
                            { meal in
                                MealSearchCell(meal: meal, calendarEntryPoint: calendarEntryPoint , completion: self.completion)
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
                        Text(categorySelected.uppercased())
                    }
                }
                .padding(.top, -35)
                .navigationTitle("Search More")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .background(Color.customBlue1.ignoresSafeArea())
                
                if viewModel.callFromApiIsLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.customBlue1))
                        .scaleEffect(3)
                }
            }
        }
        .onAppear {
            viewModel.getMeals(category: MealsCategory(rawValue: categorySelected) ?? .beef)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: MealsViewModel())
    }
}
