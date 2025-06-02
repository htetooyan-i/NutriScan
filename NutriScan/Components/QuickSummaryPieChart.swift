//
//  QuickSummaryPieChart.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 3/6/25.
//

import SwiftUI
import Charts

struct QuickSummaryPieChart: View {
    @Binding var foodNutrients: [FoodNutrient]
    var body: some View {
        VStack {
            (Chart(foodNutrients) { nutrient in
                SectorMark(
                    angle: .value(
                        Text(verbatim: nutrient.name),
                        nutrient.value
                    )
                )
                .foregroundStyle(.linearGradient(
                    colors: [nutrient.color, nutrient.color.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                ))
            })
            .frame(maxWidth: .infinity, minHeight: 200)
            
            HStack(alignment: .center, spacing: 6) {
                ForEach(foodNutrients) { nutrient in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(nutrient.color.opacity(0.5))
                            .frame(width: 10, height: 10)
                        Text(nutrient.name)
                            .font(.caption)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(Color("InversedPrimary"))
        )
    }
}
