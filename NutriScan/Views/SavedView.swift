//
//  SavedView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 14/5/25.
//

import SwiftUI

struct SavedView: View {
    @ObservedObject var foodCache = FoodCache.shared
    let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
    @State var data: [String: [[String: Any]]] = [:]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 16) {
                    ForEach(Array(data.keys), id: \.self) { date in
                        
                        Text(date)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.all)
                        
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            if let foods = data[date] {
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
            .navigationTitle("Saved")
        }
        .onAppear {
            if foodCache.isUpdated {
                self.data = foodCache.foodDataCache
            }
        }
        
        .onChange(of: foodCache.isUpdated) { oldValue, newValue in
            if newValue {
                self.data = foodCache.foodDataCache
            }
        }

    }
}
