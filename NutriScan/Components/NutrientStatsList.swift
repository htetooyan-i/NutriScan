//
//  NutrientStatsList.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 24/5/25.
//

import SwiftUI

struct NutrientStatsList: View {
    @State var date: String
    @State var nutrientName: String
    @State var data: [String: [String: [String]]] = [:]
    @State var unit: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let nutrients = data[date] {
                    ForEach(Array(nutrients.keys), id: \.self) { nutrient in
                        ForEach(nutrients[nutrient] ?? [], id: \.self) { value in
                            HStack {
                                Text(nutrient.capitalized)
                                Spacer()
                                Text("\(value) \(value == "N/A" ? "" : self.unit)")
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(Color(UIColor.systemGray6))
                            )
                        }
                    }
                } else {
                    Text("No data available for \(date)")
                        .padding()
                }
            }
            .padding()
            .navigationTitle("\(date)")
        }
        .onAppear {
            switch self.nutrientName {
            case "Calories":
                self.data = FoodCache.shared.caloriesDataCache
            case "Protein":
                self.data = FoodCache.shared.proteinDataCache
            case "Fiber":
                self.data = FoodCache.shared.fiberDataCache
            case "Fat":
                self.data = FoodCache.shared.fatDataCache
            default:
                break
            }
        }
    }
}

