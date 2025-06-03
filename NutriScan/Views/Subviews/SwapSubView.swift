//
//  PredictionSubView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 7/5/25.
//

import SwiftUI
import CoreML
import Vision

struct SwapSubView: View {
    var predictions: [VNClassificationObservation]
    @Binding var selectedFood: VNClassificationObservation?
    @State var thumbnails: [String: URL] = [:]
    
    var body: some View {
        // loop to show all food predictions
        ForEach(predictions, id: \.identifier) { prediction in
            // Show all predictions apart from selected prediction
            if prediction.identifier != selectedFood?.identifier {
                
                HStack {
                    
                    FoodChoices( // Call FoodChoice view component
                        foodName: prediction.identifier,
                        foodConfidence: prediction.confidence,
                        foodThumb: thumbnails[prediction.identifier as String])
                    ZStack{ // Swap UI Button that swap selected food
                        Circle()
                            .fill(Color("PriColor").opacity(0.5))
                            .frame(width: 40, height: 40)
                        Image(systemName: "arrow.up.arrow.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.primary)
                            .fontWeight(.thin)
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedFood = prediction
                        }
                    }
                }
            }
        }
    }
}
