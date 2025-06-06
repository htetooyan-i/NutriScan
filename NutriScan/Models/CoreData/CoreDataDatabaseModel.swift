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
    
    func saveFoodDataToCoreData(foodData: FoodData, userId: String, context: NSManagedObjectContext) {
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
    
//    func saveAccountInfoToCoreData(accountData: AccountInfo, context: NSManagedObjectContext) {
//        let account = AccountInfoEntity(context: context)
//        
//        account.userId = accountData.userId
//        account.accountType = accountData.accountType
//        account.email = accountData.email
//        account.lastModified = accountData.lastModified
//        
//        
//        
//    }
    
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
