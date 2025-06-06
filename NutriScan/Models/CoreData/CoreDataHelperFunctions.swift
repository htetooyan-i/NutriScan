//
//  CoreDataHelperFunctions.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 6/6/25.
//

import Foundation
import CoreData

class CoreDataHelperFunctions {
    static let shared = CoreDataHelperFunctions()
    
    func storeFirebaseDataToCoreData(context: NSManagedObjectContext) {
        let userId = UserManager.shared.userId
        
        DatabaseModel.getFoodDataForUser(user: userId, collectionName: "foods") { data in
            context.perform {
                for food in data {
                    CoreDataDatabaseModel.shared.saveFoodDataToCoreData(foodData: food, userId: userId, context: context)
                }
                
                do {
                    try context.save()
                    print("Food Data have been successfully stored in coreData")
                }catch {
                    print("Failed to store data to CoreData: \(error.localizedDescription)")
                }
            }
        }
        
        
    }
}
