//
//  MealsSearchCell.swift
//  SearchView
//
//  Created by Isaac Dimas on 01/10/23.
//

import SwiftUI


struct MealSearchCell: View {
    
    var meal: Meal?
    
    var body: some View {
        
        ZStack{
            
            NavigationLink("", destination:
                            MealDetailViewRepresentable(idMeal: meal?.idMeal ?? "")
                            .edgesIgnoringSafeArea(.all)
            )

            Color.customWhite1
            
            HStack {
                
                let urlStr = meal?.strMealThumb
                let url = URL(string: urlStr ?? "")
                
                ImageView(url: url) {
                    
                }
                .frame(width: 70, height: 80)
                .cornerRadius(20)
                .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text(meal?.strMeal ?? "XXX")
                        .frame(height: 70)
                        .font(.body)
                        //.fontWeight(.regular)
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
                Spacer()
                
            }
        }
    }
    
}

struct MealSearchCell_Previews: PreviewProvider {
    static var previews: some View {
        MealSearchCell(meal: Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53049"))
    }
}

struct MealDetailViewRepresentable: UIViewControllerRepresentable {
    
    var idMeal: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let mealDetailVC = MealDetailViewController()
        mealDetailVC.idMeal = idMeal
        return mealDetailVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
