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
import CoreXLSX

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
    
    // MARK: - FUNCTIION TO CHANGE FORMAT OF THE CALCULATED VALUES
    
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
    
    // MARK: - FUNCTION TO SORT SAVED FOODS BY ITS CREATION DATE
    
    static func sortByDate(for foodData: [String: [[String: Any]]]) -> ([String: [[String: Any]]], [String]) {
        var sortedData: [String: [[String: Any]]] = [:]

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMMM dd, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        let sortedKeys = foodData.keys.sorted {
            guard let d1 = formatter.date(from: $0),
                  let d2 = formatter.date(from: $1) else { return false }
            return d1 > d2
        }

        for key in sortedKeys {
            sortedData[key] = foodData[key]
        }

        return (sortedData, sortedKeys)
    }
    
    // MARK: - FUNCTION TO FILTER THE SAVED FOODS USING USER'S INPUT DATA
    
    static func searchFoods(for searchText: String, in foods: [String: [[String: Any]]]) -> ([String: [[String: Any]]], [String]) {
        var filteredFoods: [String: [[String: Any]]] = [:]
        
        for (day, foodEntries) in foods {
            var filteredEntries: [[String: Any]] = []
            
            for entry in foodEntries {
                if let selectedFood = entry["SelectedFood"] as? String,
                   selectedFood.localizedCaseInsensitiveContains(searchText) {
                    filteredEntries.append(entry)
                }
            }
            
            if !filteredEntries.isEmpty {
                filteredFoods[day] = filteredEntries
            }
        }
        
        let sortedFood = self.sortByDate(for: filteredFoods)
        
        return (sortedFood.0, sortedFood.1)
    }

    static func getAvailableFoodList() -> [String] {
        var foodList: [String] = []
        if let filePath = Bundle.main.path(forResource: "class_labels", ofType: "txt") {
            do {
                let content = try String(contentsOfFile: filePath, encoding: .utf8)
                foodList = content.components(separatedBy: .newlines)
            } catch {
                print("Error reading file: \(error)")
            }
        }
        return foodList

    }
    
    static func checkEmailAndPasswordValidity(_ email: String, _ password: String) -> [String: Bool] {
        var validityChecks: [String: Bool] = [:]
        
        // Email validations
        validityChecks["isEmailNotEmpty"] = !email.isEmpty
        
        var isEmailValid: Bool {
            // simple regex for email validation
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: email)
        }
        
        validityChecks["isEmailValid"] = isEmailValid
        
        validityChecks["isPasswordNotEmpty"] = !password.isEmpty
        
        validityChecks["isPasswordLongEnough"] = password.count >= 6

        var hasUppercasePassword: Bool {
            let upperCase = CharacterSet.uppercaseLetters
            return password.rangeOfCharacter(from: upperCase) != nil
        }
        
//        validityChecks["hasUppercasePassword"] = hasUppercasePassword
        
        return validityChecks

    }

}
