//
//  FoodData.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 2/6/25.
//

import Foundation
import FirebaseFirestore

struct FoodData: Codable {
    let SelectedFood: String
    let foodCalories: String
    let foodFat: String
    let foodFiber: String
    let foodId: String
    let foodPredictions: [String: Double]
    let foodPrice: Double
    let foodProtein: String
    let foodQuantity: Int
    let foodWeight: String
    let imageURL: String
    let timestamp: Timestamp
}

