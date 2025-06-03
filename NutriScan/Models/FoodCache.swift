//
//  FoodCache.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 14/5/25.
//

import Foundation
import FirebaseCore

class FoodCache: ObservableObject {
    static let shared = FoodCache()
    
    @Published var foodDataCache: [FoodData] = []
    @Published var foodDataCacheByDate: [String: [FoodData]] = [:]
    @Published var caloriesDataCache: [String: [String: [String]]] = [:]
    @Published var proteinDataCache: [String: [String: [String]]] = [:]
    @Published var fiberDataCache: [String: [String: [String]]] = [:]
    @Published var fatDataCache: [String: [String: [String]]] = [:]
    @Published var priceDataCache: [String: [String: [String]]] = [:]
    @Published var isUpdated: Bool = false
    
    func setFoodData(data: [FoodData]) {
        self.isUpdated = false
        self.foodDataCacheByDate = [:]
        self.foodDataCache = data
        // Change types: [String: [String: [String]]]
        var updatedCaloriesData: [String: [String: [String]]] = [:]
        var updatedProteinData: [String: [String: [String]]] = [:]
        var updatedFiberData: [String: [String: [String]]] = [:]
        var updatedFatData: [String: [String: [String]]] = [:]
        var updatedPriceData: [String: [String: [String]]] = [:]
        
        var updatedFoodData: [String: [FoodData]] = [:]

        for food in data {
            
            let date = HelperFunctions.dateFormatter(timestamp: food.timestamp, format: "EEEE MMMM dd, yyyy")

            updatedFoodData[date, default: []].append(food)
            
            updatedCaloriesData[date, default: [:]][food.SelectedFood, default: []].append(food.foodCalories)
            updatedProteinData[date, default: [:]][food.SelectedFood, default: []].append(food.foodProtein)
            updatedFiberData[date, default: [:]][food.SelectedFood, default: []].append(food.foodFiber)
            updatedFatData[date, default: [:]][food.SelectedFood, default: []].append(food.foodFat)
            updatedPriceData[date, default: [:]][food.SelectedFood, default: []].append(String(food.foodPrice))
        }
        
        // Now you have arrays of nutrient values per food per date
        self.foodDataCacheByDate = updatedFoodData
        self.caloriesDataCache = updatedCaloriesData
        self.proteinDataCache = updatedProteinData
        self.fiberDataCache = updatedFiberData
        self.fatDataCache = updatedFatData
        self.priceDataCache = updatedPriceData

        print("All Foods Data Has Been Successfully Stored In Cache")
        DispatchQueue.main.async {
            self.isUpdated = true
        }
    }

    
    
    func getSavedFoodData() -> [String: [FoodData]] { // get the food data from cache data
        return self.foodDataCacheByDate
    }
    
}
