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
    
    @Published var foodDataCache: [String: [[String: Any]]] = [:]
    @Published var caloriesDataCache: [String: [String: [String]]] = [:]
    @Published var proteinDataCache: [String: [String: [String]]] = [:]
    @Published var fiberDataCache: [String: [String: [String]]] = [:]
    @Published var fatDataCache: [String: [String: [String]]] = [:]
    @Published var priceDataCache: [String: [String: [String]]] = [:]
    @Published var isUpdated: Bool = false
    
    func setFoodData(data: [[String: Any]]) {
        self.isUpdated = false
        self.foodDataCache = [:]
        
        // Change types: [String: [String: [String]]]
        var updatedCaloriesData: [String: [String: [String]]] = [:]
        var updatedProteinData: [String: [String: [String]]] = [:]
        var updatedFiberData: [String: [String: [String]]] = [:]
        var updatedFatData: [String: [String: [String]]] = [:]
        var updatedPriceData: [String: [String: [String]]] = [:]
        
        var updatedFoodData: [String: [[String: Any]]] = [:]

        for food in data {
            if let timestamp = food["timestamp"] as? Timestamp {
                let date = HelperFunctions.dateFormatter(timestamp: timestamp, format: "EEEE MMMM dd, yyyy")
                
                if updatedFoodData[date] == nil {
                    updatedFoodData[date] = [food]
                } else {
                    updatedFoodData[date]?.append(food)
                }
                
                if let calories = food["foodCalories"] as? String,
                   let selectedFood = food["SelectedFood"] as? String {
                    updatedCaloriesData[date, default: [:]][selectedFood, default: []].append(calories)
                }
                
                if let protein = food["foodProtein"] as? String,
                   let selectedFood = food["SelectedFood"] as? String {
                    updatedProteinData[date, default: [:]][selectedFood, default: []].append(protein)
                }
                
                if let fiber = food["foodFiber"] as? String,
                   let selectedFood = food["SelectedFood"] as? String {
                    updatedFiberData[date, default: [:]][selectedFood, default: []].append(fiber)
                }
                
                if let fat = food["foodFat"] as? String,
                   let selectedFood = food["SelectedFood"] as? String {
                    updatedFatData[date, default: [:]][selectedFood, default: []].append(fat)
                }
                if let price = food["foodPrice"] as? Double,
                   let selectedFood = food["SelectedFood"] as? String {
                    updatedPriceData[date, default: [:]][selectedFood, default: []].append(String(price))
                }
            }
        }
        
        // Now you have arrays of nutrient values per food per date
        self.foodDataCache = updatedFoodData
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

    
    
    func getSavedFoodData() -> [String: [[String: Any]]] { // get the food data from cache data
        return self.foodDataCache
    }
    
}
