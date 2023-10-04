//
//  MealsAppTests.swift
//  MealsAppTests
//
//  Created by Isaac Dimas on 02/10/23.
//

import XCTest
@testable import MealsApp

final class MealsAPITests: XCTestCase {

    var mealsAPI: MealsAPI!
    var mealModel: Meal!
    var mealDetailModel: MealDetail!
    
    override func setUpWithError() throws {
        
        // Arrange
        self.mealsAPI = MealsAPI()
        self.mealModel = Meal.mealModelMock
        self.mealDetailModel = MealDetail.mealDetailModelMock
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.mealsAPI = nil
        self.mealModel = nil
        self.mealDetailModel = nil
    }
    
    func testMealsCategoryAPI_WhenGivenSuccessfullResponseFromCategoriesEntryPointWith_ValidCategory_ReturnsSuccessAndMealsArray() {
        
        // Arrange
        let expectation = self.expectation(description: "A successfull request and response from the API")
        
        // Act
        self.mealsAPI.getMealsFromAPI(category: .dessert, completion: { meals, statusCode in
            
            // Assert
            guard let meals = meals else {
                XCTAssertEqual(statusCode, MealsAPIStatusCode.success, "URL not found")
                XCTAssertNotNil(meals, "The data wasn´t parsed correctly or is missing")
                return
            }
            
            XCTAssertEqual(statusCode, MealsAPIStatusCode.success, "The status code isn´t 200")
            XCTAssertNotNil(meals, "The response was successfull")
            XCTAssertFalse(meals.isEmpty, "The response was successfull but meals weren't recovered, maybe the entry point isn´t available")
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 10)
    }
    
    func testMealsCategoryAPI_WhenGivenSuccessfullResponseFromCategoriesEntryPointWith_UnvalidCategory_ReturnsSuccess_ButNilMealsArray() {
        
        // Arrange
        let expectation = self.expectation(description: "Success response but empty meals array")
        
        // Act
        self.mealsAPI.getMealsFromAPI(category: nil, completion: { meals, statusCode in
            
            // Assert
            XCTAssertEqual(statusCode, MealsAPIStatusCode.success, "The status code isn´t 200")
            XCTAssertNil(meals, "Meals were recovered from the API")
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 15)
    }
    
    func testMealsByIDAPI_WhenGivenSuccessfullResponseWith_ValidID_ReturnsSuccess_AndMealDetails() {
        
        // Arrange
        let expectation = self.expectation(description: "A successfull request and response from the API")
        
        // Act
        self.mealsAPI.getMealDetailFromAPI(idMeal: MealDetail.mealDetailModelMock.idMeal!, completion: { meal, statusCode in
            
            // Assert
            guard let meal = meal else {
                XCTAssertEqual(statusCode, MealsAPIStatusCode.success, "URL not found")
                XCTAssertNotNil(meal, "The data wasn´t parsed correctly or is missing")
                return
            }
            
            XCTAssertEqual(statusCode, MealsAPIStatusCode.success, "The status code isn´t 200")
            XCTAssertNotNil(meal, "The response was successfull")
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 10)
    }
    
    func testMealsByIDAPI_WhenGivenSuccessfullResponseWith_UnvalidID_ReturnsSuccess_ButNilMealDetails() {
        
        // Arrange
        let expectation = self.expectation(description: "A successfull request and response from the API")
        
        // Act
        self.mealsAPI.getMealDetailFromAPI(idMeal: "dfdc", completion: { meal, statusCode in
            
            // Assert
            // Assert
            XCTAssertEqual(statusCode, MealsAPIStatusCode.success, "The status code isn´t 200")
            XCTAssertNil(meal, "Meals were recovered from the API")
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 10)
    }
}
