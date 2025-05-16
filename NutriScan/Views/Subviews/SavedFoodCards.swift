//
//  SavedFoodCards.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 16/5/25.
//

import SwiftUI

struct SavedFoodCards: View {
    let sortedKeys: [String]
    let data: [String: [[String: Any]]]
    
    let columns = [ // create rows with 2 columns
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            ForEach(sortedKeys, id: \.self) { date in // food data will be sorted by its creation date
                Text(date)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.all)
                
                LazyVGrid(columns: columns, spacing: 20) { // create a vertical grid with 2 columns in each row
                    if let foods = data[date] { // create food data is available or not(In this case food data will be definately available)
                        ForEach(Array(foods.enumerated()), id: \.offset) { idx, food in
                            if let foodName = food["SelectedFood"] as? String,
                               let predictions = food["foodPredictions"] as? [String: Double],
                               let predictionConfidence = predictions[foodName],
                               let urlString = food["imageURL"] as? String,
                               let imageURL = URL(string: urlString) {
                                
                                FoodCard(imageURL: imageURL, foodName: foodName, predictionConfidence: predictionConfidence)
                            }
                        }
                    }
                }
            }
        }

    }
}
