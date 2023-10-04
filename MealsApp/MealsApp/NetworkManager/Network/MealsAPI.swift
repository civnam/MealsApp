//
//  MealsAPI.swift
//  MealsApp
//
//  Created by Isaac Dimas on 30/09/23.
//

import Foundation

class MealsAPI {
    
    // MARK: - Atributes
    private var urlSession: URLSession
    private let mealsAPIUrl: String = "https://themealdb.com/api/json/v1/1/filter.php?c="
    private let mealDetailAPIUrl: String = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    // MARK: - Init
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - Methods
    func getMealsFromAPI(category: MealsCategory?, completion: @escaping ( [Meal]?, MealsAPIStatusCode ) -> Void) {
        
        let urlStr = mealsAPIUrl + (category?.categoryName ?? "")
        
        guard let url = URL(string: urlStr) else {
            completion(nil, .notFound)
            return
        }
        
        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 && error == nil {
                
                do {
                    if let data = data {
                        let decoder = JSONDecoder()
                        let parsedData = try decoder.decode(MealsAPIResponse.self, from: data)
                        completion(parsedData.meals, .success)
                    }
                } catch {
                    completion(nil, .success)
                }
            }
        })
        
        task.resume()
    }
    
    func getMealDetailFromAPI(idMeal: String, completion: @escaping ( MealDetail?, MealsAPIStatusCode ) -> Void) {
        
        let urlStr = mealDetailAPIUrl + idMeal
        
        guard let url = URL(string: urlStr) else {
            completion(nil, .notFound)
            return
        }
        
        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 && error == nil {
                
                do {
                    if let data = data {
                        
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
                        
                        let mealDetail = self.getMealDetail(jsonDict: jsonDict)
                        completion(mealDetail, .success)
                    }
                } catch {
                    completion(nil, .success)
                }
            }
        })
        
        task.resume()
    }
    
    private func getMealDetail(jsonDict: [String: Any]?) -> MealDetail? {
        let customJSON = getMealsDict(jsonDict: jsonDict)
        let mealDetail = encodeAndDecodeDict(dictionary: customJSON)
        return mealDetail
    }
    
    /// JSON parsing for reducing the model of the MealDeatil, so the ingredients and the measures are reduced into just one array respectively
    private func getMealsDict(jsonDict: [String: Any]?) -> [String : Any] {
        
        guard let jsonDict = jsonDict else { return [:] }
        
        let mealsValue = jsonDict["meals"] as? [[String: Any]]
        
        guard let mealsValue = mealsValue, var mealsDict = mealsValue.first else {
            return [:]
        }
        
        var arrIngredients: [String] = [String]()
        var arrMeasures: [String] = [String]()
        var ingredient: String = ""
        var measure: String = ""
        
        for number in 1...20 {
            let ingredientDictKey = "strIngredient\(number)"
            let measureDictKey = "strMeasure\(number)"
            ingredient = mealsDict[ingredientDictKey] as? String ?? ""
            measure = mealsDict[measureDictKey] as? String ?? ""
            mealsDict.removeValue(forKey: ingredientDictKey)
            mealsDict.removeValue(forKey: measureDictKey)
            if ingredient == "" {
                continue
            }
            arrIngredients.append(ingredient)
            arrMeasures.append(measure)
        }
        
        mealsDict["arrIngredients"] = arrIngredients as Any
        mealsDict["arrMeasures"] = arrMeasures as Any
        
        return mealsDict
    }
    
    /// Encode the dictionary for using it in the JSONDecoder object and parse the data according to MealDetail model
    private func encodeAndDecodeDict(dictionary: [String: Any]) -> MealDetail? {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let decoder = JSONDecoder()
            let parsedData = try decoder.decode(MealDetail.self, from: jsonData)
            return parsedData
        } catch {
            return nil
        }
    }
}
