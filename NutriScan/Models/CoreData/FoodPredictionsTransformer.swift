//
//  FoodPredictionsTransformer.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 6/6/25.
//

import Foundation
import CoreData

@objc(FoodPredictionsTransformer)
final class FoodPredictionsTransformer: ValueTransformer {
    override class func allowsReverseTransformation() -> Bool { true }

    override class func transformedValueClass() -> AnyClass {
        NSData.self
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let predictions = value as? [String: Double] else { return nil }
        do {
            return try JSONEncoder().encode(predictions)
        } catch {
            print("Encoding error: \(error)")
            return nil
        }
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            return try JSONDecoder().decode([String: Double].self, from: data)
        } catch {
            print("Decoding error: \(error)")
            return nil
        }
    }
}
