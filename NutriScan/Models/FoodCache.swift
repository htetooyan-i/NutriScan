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
    @Published var isUpdated: Bool = false
    func setAll(data: [[String: Any]]) {
        self.isUpdated = false
        self.foodDataCache = [:]
        
        var updatedFoodData: [String: [[String: Any]]] = [:]
        
        for food in data {
            if let timestamp = food["timestamp"] as? Timestamp {
                let date = HelperFunctions.dateFormatter(for: timestamp)
                
                if updatedFoodData[date] == nil {
                    updatedFoodData[date] = [food]
                }else {
                    updatedFoodData[date]?.append(food)
                }
            }
        }
        
        self.foodDataCache = updatedFoodData
        print("All Foods Data Has Been Successully Stored In Cache")
        DispatchQueue.main.async {
            self.isUpdated = true
        }
    }
    
    func getAll() -> [String: [[String: Any]]] {
        return self.foodDataCache
    }
}
