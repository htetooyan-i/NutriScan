//
//  PersistenceController.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 6/6/25.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        
        ValueTransformer.setValueTransformer(FoodPredictionsTransformer(), forName: NSValueTransformerName("FoodPredictionsTransformer"))
        
        container = NSPersistentContainer(name: "Model") // Must match your .xcdatamodeld filename
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
}

