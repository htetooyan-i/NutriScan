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
import SwiftUI

class HelperFunctions: ObservableObject {
    
    // MARK: - Function To Create Food Data
    static func createFoodDataInDatabase(
        results: ClassificationModel,
        user: String,
        collectionName: String,
        takenPicData: UIImage?,
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
        
        if let selectedImage = takenPicData,
           let imageData = selectedImage.jpegData(compressionQuality: 0.8),
           imageData.count > 0 {
            
            DatabaseModel.createFoodDataForUser(user: user, collectionName: collectionName, foodDataArray: foodDataArray, takenPicData: imageData) { isSuccess, dataId in
                if isSuccess {
                    print("Data saved successfully!")
                    // sent back dataId to sheetView
                    completion(dataId)
                } else {
                    print("Failed to save data.")
                    completion(nil)
                }
            }
        } else {
            print("❌ Failed to get valid image data")
        }
    }
    
    // MARK: - Function To Read Food Data
    
    static func getFoodDataFromDatabase(user: String, collectionName: String) {
        DatabaseModel.getFoodDataForUser(user: user, collectionName: collectionName) { data in
            FoodCache.shared.setFoodData(data: data)
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
            DatabaseModel.deleteFoodDataForUser(user: user, collectionName: "foods", deleteId: deleteId) { isSuccess in
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
        
        let calories = formatNutrient(baseCalories * multiplier)
        let protein = formatNutrient(baseProtein * multiplier)
        let fiber = formatNutrient(baseFiber * multiplier)
        let fat = formatNutrient(baseFat * multiplier)
        
        return (calories, protein, fiber, fat)
    }
    
    // MARK: - FUNCTIION TO CHANGE FORMAT OF THE CALCULATED VALUES
    
    private static func formatNutrient(_ value: Double) -> String {
        return value.isNaN ? "N/A" : String(format: "%.2f", value)
    }
    
    // MARK: - FUNCTION TO CHANGE DATE FORMAT
    
    static func dateFormatter(timestamp: Date? = nil, timeString: String? = nil, format: String) -> String {
        var date: Date?
        
        if let timestamp = timestamp {
            date = timestamp
        } else if let timeString = timeString {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "EEEE MMMM dd, yyyy"
            inputFormatter.locale = Locale(identifier: "en_US")
            inputFormatter.timeZone = TimeZone(secondsFromGMT: 7 * 3600)
            
            date = inputFormatter.date(from: timeString)
        } else {
            return ""
        }
        
        guard let validDate = date else { return "" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format
        outputFormatter.locale = Locale(identifier: "en_US")
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 7 * 3600)
        
        return outputFormatter.string(from: validDate)
    }
    
    // MARK: - FUNCTION TO SORT SAVED FOODS BY ITS CREATION DATE
    
    static func sortSavedFoodByDate(for foodData: [String: [FoodData]]) -> ([String: [FoodData]], [String]) {
        var sortedData: [String: [FoodData]] = [:]
        
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
    
    static func searchFoods(for searchText: String, in foods: [String: [FoodData]]) -> ([String: [FoodData]], [String]) {
        var filteredFoods: [String: [FoodData]] = [:]
        
        for (day, foodEntries) in foods {
            var filteredEntries: [FoodData] = []
            
            for entry in foodEntries {
                let selectedFood = entry.SelectedFood
                if selectedFood.localizedCaseInsensitiveContains(searchText) {
                    filteredEntries.append(entry)
                }
            }
            
            if !filteredEntries.isEmpty {
                filteredFoods[day] = filteredEntries
            }
        }
        
        let sortedFood = self.sortSavedFoodByDate(for: filteredFoods)
        
        return (sortedFood.0, sortedFood.1)
    }
    
    // MARK: -  FUNCTION TO GET AVAILABLE FOOD LIST
    
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
    // MARK: - FUNCTION TO CHECK CURRENT EMAIL AND PASSWORD PASS THE VALIDATION RULES
    
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
    
    static func getTodayReview(completion: @escaping (([String: Double], [String])) -> Void) {
        var review: [String: Double] = [
            "totalCalories": 0,
            "totalProtein": 0,
            "totalFiber": 0,
            "totalFat": 0,
            "totalWeight": 0,
        ]
        var foodsNotFound: [String] = []
        
        DatabaseModel.getFoodDataForUser(
            user: UserManager.shared.userId,
            collectionName: "foods",
            queryField: "timestamp",
            queryValue: Calendar.current.startOfDay(for: Date())
        ) { data in
            for food in data {
                
                func extractDouble(from value: Any?) -> Double? {
                    if let str = value as? String {
                        return Double(str)
                    }
                    return nil
                }
                
                if let calories = extractDouble(from: food.foodCalories),
                   let fat = extractDouble(from: food.foodFat),
                   let protein = extractDouble(from: food.foodProtein),
                   let fiber = extractDouble(from: food.foodFiber),
                   let weight = extractDouble(from: food.foodWeight) {
                    
                    review["totalCalories", default: 0] += calories
                    review["totalFat", default: 0] += fat
                    review["totalProtein", default: 0] += protein
                    review["totalFiber", default: 0] += fiber
                    review["totalWeight", default: 0] += weight
                    
                } else {
                    foodsNotFound.append(food.SelectedFood)
                }
            }
            
            completion((review, foodsNotFound))
        }
    }
    
    static func getStatsTotal(for nutrient: [String: [String: [String]]]) -> [String: Double] {
        var foodData: [String: Double] = [:]
        
        for (date, innerDict) in nutrient {
            var totalValue: Double = 0
            
            for (_, valueStrings) in innerDict {
                for valueString in valueStrings {
                    if let value = Double(valueString) {
                        totalValue += value
                    }
                }
            }
            
            foodData[date] = totalValue
        }
        
        return foodData
    }
    
    // MARK: - FUNCTION TO SORT SAVED STATS BY ITS CREATION DATE IN Summary View
    
    static func sortStatsByDate(for foodData: [String: Double]) -> ([String]) {
        var sortedData: [String: Double] = [:]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMMM dd, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let sortedKeys = foodData.keys.sorted {
            guard let d1 = formatter.date(from: $0),
                  let d2 = formatter.date(from: $1) else { return false }
            return d1 < d2
        }
        
        for key in sortedKeys {
            sortedData[key] = foodData[key]
        }
        
        return sortedKeys
    }
    
    static func getSecretKey(named key: String) -> String? {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
           let value = dict[key] as? String {
            return value
        }
        return nil
    }
    
    // MARK: - Function To Read User Personal Data
    
    static func getUserDataFromDatabase() {
        UserCache.shared.setPersonalInfo()
    }
    
    // MARK: - Function To Read User Account Data
    
    static func getUserAccDataFromDatabase() {
        UserCache.shared.setAccountInfo()
    }
    
    
    static func generatePromtForOverallDetail(personlInfo: PersonalInfo? = nil, foodInfo: [String: [FoodData]])-> String {
        var prompt = ""
        let currentDate = self.dateFormatter(timestamp: Date(), format: "EEEE MMMM dd, yyyy")
        if let info = personlInfo {
            prompt += "Personal Info:\n"
            prompt += "Height: \(info.height)\n"
            prompt += "Weight: \(info.weight)\n"
            prompt += "Gender: \(info.gender)\n"
            prompt += "Age: \(info.age)\n\n"
        }
        
        for (dt, foods) in foodInfo {
            
            if dt == currentDate {
                for (index, foodItem) in foods.enumerated() {
                    
                    prompt += "  food \(index + 1):\n"
                    
                    let mirror = Mirror(reflecting: foodItem)
                    for child in mirror.children {
                        if let key = child.label {
                            prompt += "    \(key): \(child.value)\n"
                        }
                    }
                }

                prompt += "\n"
            }
            
        }
        //        prompt += "This is user's today food detail and i will use this prompt for my app that is builded for education purpose so I want to write as paragraph, only use list for food detail and that is suitable for ui display on ios swift use font design like italic, bold for some words for better visalization and add subheadings. I want to get the nutrition information from this data and calculate bmi and give alitte bit of advice. when food data is N/A add suitable data. **Make your response like explaining in conversation. Don't be like giving facts and avoid usages like user's.don't add any calculation and **write only as passage.** Reduce word as much as you can. Don't add words like Alright, sure at the start of the response"
        
        prompt += """
        
        Please respond with exactly three paragraphs, each starting with a subheading as shown below:
        
        **Food Details**
        
        [List the all food that in prompt briefly with quantity, calories, protein, fat, and fiber. if food data is N/A add suitable data]
        
        **BMI Analysis**  
        
        [Calculate the BMI from height and weight, and describe the BMI category: underweight, normal, overweight, or obese.]
        
        **Health Advice**
        
        [Give friendly, concise health feedback and advice based on the food and BMI.]
        
        Format your response exactly like this, with the subheadings on their own lines, and paragraphs separated by a blank line.
        
        """
        
        return prompt
        
    }
    
    static func makeVibration(feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: feedbackStyle)
        generator.prepare()
        generator.impactOccurred()
    }
    
    static func makeSaveSound() {
        SoundManager.shared.playClickSound()
    }
    
    static func deleteSelectedFoods(seletedFoods: [String], completion: @escaping (Bool) -> Void) {
        for foodId in seletedFoods {
            DatabaseModel.deleteFoodDataForUser(user: UserManager.shared.userId, collectionName: "foods", deleteId: foodId) { isSuccess in
                if isSuccess {
                    print("Successfully deleted: \(foodId)")
                }else {
                    completion(false)
                }
            }
        }
        
        completion(true)
    }
    
    static func getSelectedFoodData(selectedFoodIds: [String], completion: @escaping ([FoodData]?) -> Void) { // Need to Implement This Func When Food data has been decoded directly in database model
        var foodDataList: [FoodData] = []
        let foods = FoodCache.shared.foodDataCache // [[String: Any]]

        for food in foods {
            if  selectedFoodIds.contains(food.foodId) {
                foodDataList.append(food)
            } else {
                print("Missing or invalid field for foodId: \(food.foodId)")
            }
        }

        completion(foodDataList)
    }
    
    
    static func getTotalNutrients(for data: [FoodData]) -> Nutrients {
        
        var localCalories: Double = 0
        var localProtein: Double = 0
        var localFiber: Double = 0
        var localFat: Double = 0
        
        for food in data {
            if food.foodCalories != "N/A" {
                print(food.foodCalories)
                localCalories += Double(food.foodCalories)!
            }
            
            if food.foodProtein != "N/A" {
                localProtein += Double(food.foodProtein)!
            }
            
            if food.foodFiber != "N/A" {
                localFiber += Double(food.foodFiber)!
            }
            
            if food.foodFat != "N/A" {
                localFat += Double(food.foodFat)!
            }
        }
        
        let nutrients = Nutrients(
            calories: localCalories,
            protein: localProtein,
            fiber: localFiber,
            fat: localFat
        )
        
        return nutrients
    }
    
    static func calcuateNutrientPercentage(for nutrients: Nutrients) -> (protein: Double, fiber: Double, fat: Double) {
        
        let totalNutrients = nutrients.protein + nutrients.fiber + nutrients.fat

        let proteinPercentage = (nutrients.protein / totalNutrients)
        let fiberPercentage = (nutrients.fiber / totalNutrients)
        let fatPercentage = (nutrients.fat / totalNutrients)
        
        return (proteinPercentage, fiberPercentage, fatPercentage)
    }
    
    static func getFoodThumbnail(for foodName: String) async -> URL? {
        return await withCheckedContinuation { continuation in
            DatabaseModel.getFoodThumbnail(foodName: foodName) { imgURL in
                continuation.resume(returning: imgURL)
            }
        }
    }
    
    static func getTotalPrice(for foods: [FoodData]) -> Double {
        return foods.reduce(0) { $0 + $1.foodPrice }
    }
    
    static func updateUserAccountInfo() {
        let isLoggedIn = UserManager.shared.isLoggedIn
        
        @AppStorage("photoSaving") var photoSaving: Bool?
        
        if let photoSaving = photoSaving, isLoggedIn {
            let updatedArray = [
                "photoSaving": photoSaving
            ]
            
            UserManager.shared.updateAccountInfo(user: UserManager.shared.userId, updatedArray: updatedArray, completion: { _ in })
        }
    }
    
    
}
