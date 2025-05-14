//
//  MainPredictionSubView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 9/5/25.
//

import SwiftUI
import Vision

struct MainPredictionSubView: View {
    
    var selectedFood: VNClassificationObservation?
    @ObservedObject var results: ClassificationModel
    @Binding var saved: Bool
    @ObservedObject var nutritionData: NutritionModel
    
    var body: some View {
        VStack{
            // Show highest confidence food
            Prediction(
                foodName: selectedFood?.identifier ?? results.predictions.first?.identifier,
                confidence: selectedFood?.confidence ?? results.predictions.first?.confidence,
                thumb: nutritionData.nutrientInfo[selectedFood?.identifier ?? ""]?["thumbnail"] as? UIImage,
                saved: $saved
            )
            .id(selectedFood?.identifier ?? "default")
            
        }
    }
}
