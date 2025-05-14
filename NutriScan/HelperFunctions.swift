//
//  HelperFunctions.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 9/5/25.
//

import Foundation
import CoreML
import FirebaseCore
import FirebaseFirestore

class HelperFunctions: ObservableObject {
    // MARK: - Function To Create Food Data
    static func createFoodDataInDatabase(
        results: ClassificationModel,
        user: String,
        collectionName: String,
        takenPicData: Data,
        dataArray: [String: Any],
        completion: @escaping (String?) -> Void
    ) {
        // get food name and confidence to store in database as array
        let allPredictions: [String: Double] = results.predictions.reduce(into: [:]) { dict, observation in
            dict[observation.identifier] = Double(observation.confidence)
        }

        // create array to store in database
        var foodDataArray = dataArray
        foodDataArray["foodPredictions"] = allPredictions
        foodDataArray["timestamp"] = Timestamp(date: Date())
        
        DatabaseModel.createFoodDataForUser(user: user, collectionName: collectionName, foodDataArray: foodDataArray, takenPicData: takenPicData) { isSuccess, dataId in
            if isSuccess {
                print("Data saved successfully!")
                // sent back dataId to sheetView
                completion(dataId)
            } else {
                print("Failed to save data.")
                completion(nil)
            }
        }
    }
    
    // MARK: - Function To Read Food Data
    
    static func getFoodDataFromDatabase(user: String, collectionName: String) {
        DatabaseModel.getFoodDataForUser(user: user, collectionName: collectionName) { data in
            FoodCache.shared.setAll(data: data)
        }
    }
    
    // MARK: - Function To Update Food Data
    static func updateFoodDataInDatabase(user: String, collectionName: String, updateId: String, updateArray: [String: Any]) {
        DatabaseModel.updateFoodDataForUser(user: user, collectionName: collectionName, updateId: updateId, updateArray: updateArray) { isSuccess in
            if isSuccess {
                print("Successfully updated!")
            }else {
                print("Update failed!")
            }
        }
    }
    
    // MARK: - Function To Delete Data
    static func deleteFoodDataFromDatabase(
        currentDataId: String?,
        user: String,
        collectionName: String,
        completion: @escaping (Bool) -> Void
    ){
        if let deleteId = currentDataId {
            DatabaseModel.deleteFoodDataForUser(user: "user_001", collectionName: "foods", deleteId: deleteId) { isSuccess in
                if isSuccess {
                    print("Data has been deleted successfully!")
                    completion(true)
                }else{
                    print("Failed to delete data.")
                    completion(false)
                }
            }
        }else{
            print("No Data Id Found")
        }
    }
    
    // MARK: - FUNCTION TO CALCULATE NUTRITION VALUES
    static func calculateNutrition(
        baseCalories: Double,
        baseProtein: Double,
        baseFiber: Double,
        baseFat: Double,
        baseWeight: Double,
        newWeight: Double,
        baseQuantity: Double,
        newQuantity: Double
    ) -> (calories: String, protein: String, fiber: String, fat: String) {
        
        guard baseWeight > 0, newWeight > 0, baseQuantity > 0, newQuantity > 0 else {
            return ("N/A", "N/A", "N/A", "N/A")
        }
        
        let multiplier = (newWeight * newQuantity) / baseWeight
        
        let calories = formatNutrient(baseCalories * multiplier, suffix: "kcal")
        let protein = formatNutrient(baseProtein * multiplier)
        let fiber = formatNutrient(baseFiber * multiplier)
        let fat = formatNutrient(baseFat * multiplier)
        
        return (calories, protein, fiber, fat)
    }
    
    private static func formatNutrient(_ value: Double, suffix: String = "g") -> String {
        return value.isNaN ? "N/A" : String(format: "%.2f %@", value, suffix)
    }
    
    static func dateFormatter(for timestamp: Timestamp) -> String {
        let date = timestamp.dateValue()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMM dd, yyyy"
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone(secondsFromGMT: 7 * 3600)
        
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
}
