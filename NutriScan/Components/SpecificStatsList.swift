//
//  StatsList.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 24/5/25.
//

import SwiftUI

struct SpecificStatsList: View {
    @State var date: String
    @State var statName: String
    @State var data: [String: [String: [String]]] = [:]
    @State var unit: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let stats = data[date] {
                    ForEach(Array(stats.keys), id: \.self) { stat in
                        if let values: [String] = stats[stat] {
                            ForEach(values, id: \.self) { value in
                                HStack {
                                    Text(stat.capitalized)
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
                    }
                }
            }
            .padding()
            .navigationTitle("\(date)")
        }
        .onAppear {
            switch self.statName {
            case "Calories":
                self.data = FoodCache.shared.caloriesDataCache
            case "Protein":
                self.data = FoodCache.shared.proteinDataCache
            case "Fiber":
                self.data = FoodCache.shared.fiberDataCache
            case "Fat":
                self.data = FoodCache.shared.fatDataCache
            case "Price":
                self.data = FoodCache.shared.priceDataCache
            default:
                break
            }
        }
    }
}

