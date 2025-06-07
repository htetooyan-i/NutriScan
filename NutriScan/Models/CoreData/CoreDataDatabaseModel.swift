//
//  CoreDataDatabaseModel.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 6/6/25.
//

import Foundation
import CoreData

class CoreDataDatabaseModel {
    static let shared = CoreDataDatabaseModel()
    
    func saveFoodDataToCoreDataFromFibrebase(foodData: FoodData, userId: String, context: NSManagedObjectContext) {
        let food = FoodEntity(context: context)
        
        food.userId = userId
        food.selectedFood = foodData.SelectedFood
        food.foodCalories = foodData.foodCalories
        food.foodProtein = foodData.foodProtein
        food.foodFiber = foodData.foodFiber
        food.foodFat = foodData.foodFat
        food.foodPrice = foodData.foodPrice
        food.foodWeight = foodData.foodWeight
        food.foodQuantity = Int64(foodData.foodQuantity)
        food.foodPredictions = foodData.foodPredictions as NSDictionary
        food.imageURL = foodData.imageURL
        food.foodId = foodData.foodId
        food.timestamp = foodData.timestamp
        food.lastModified = foodData.lastModified
        
    }
//    
//    func saveFoodDataToCoreData(foodData: [String: Any], userId: String, context: NSManagedObjectContext) {
//        let food = FoodEntity(context: context)
//        
//        food.userId = userId
//        food.selectedFood = foodData.SelectedFood
//        food.foodCalories = foodData.foodCalories
//        food.foodProtein = foodData.foodProtein
//        food.foodFiber = foodData.foodFiber
//        food.foodFat = foodData.foodFat
//        food.foodPrice = foodData.foodPrice
//        food.foodWeight = foodData.foodWeight
//        food.foodQuantity = Int64(foodData.foodQuantity)
//        food.foodPredictions = foodData.foodPredictions as NSDictionary
//        food.imageURL = foodData.imageURL
//        food.foodId = foodData.foodId
//        food.timestamp = foodData.timestamp
//        food.lastModified = foodData.lastModified
//        
//        
//    }
    
    func saveAccountInfoToCoreData(accountData: [String: Any], context: NSManagedObjectContext) {
        let account = AccountInfoEntity(context: context)
        
        if let userId = accountData["userId"] as? String,
           let accountType = accountData["accountType"] as? String,
           let email = accountData["email"] as? String,
           let isPhotoSaving = accountData["photoSaving"] as? Bool {
                account.email = email
                account.userId = userId
                account.accountType = accountType
                account.photoSaving = isPhotoSaving
                account.lastModified = Date()
            }
        
        do {
            try context.save()
            print("Account Info Saving to CoreData Success")
        }catch {
            print("Account Info saving to CoreData failed")
        }
    }
    
    func savePersonalInfoToCoreData(personalData: [String: Any], context: NSManagedObjectContext) {
        let personalInfo = PersonalInfoEntity(context: context)
        
        if let gender = personalData["gender"] as? String,
           let height = personalData["height"] as? Double,
           let weight = personalData["weight"] as? Double,
           let age = personalData["age"] as? Int {
            personalInfo.age = Int64(age)
            personalInfo.gender = gender
            personalInfo.height = height
            personalInfo.weight = weight
            personalInfo.lastModified = Date()
        }
        
        do {
            try context.save()
            print("Account Info Saving to CoreData Success")
        }catch {
            print("Account Info saving to CoreData failed")
        }
    }
    
    func deleteAllFoods(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FoodEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            print("Deleted all foods successfully")
        } catch {
            print("Failed to delete all foods: \(error.localizedDescription)")
        }
    }

}
