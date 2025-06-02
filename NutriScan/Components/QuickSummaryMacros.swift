//
//  QuickSummaryMacros.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 3/6/25.
//

import SwiftUI

struct QuickSummaryMacros: View {
    
    @Binding var protein: Double
    @Binding var fiber: Double
    @Binding var fat: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center,spacing: 10) {
                Image(systemName: "chart.pie.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color("PriColor"))
                    .fontWeight(.bold)
                Text("Macros")
            }
            QuickSummaryStats(iconName: "fork.knife", statName: "Protein", statValue: $protein, color: .green, unit: "g")
            QuickSummaryStats(iconName: "leaf.fill", statName: "Fiber", statValue: $fiber, color: .red, unit: "g")
            QuickSummaryStats(iconName: "drop.circle.fill", statName: "Fat", statValue: $fat, color: .brown, unit: "g")
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(Color("InversedPrimary"))
        )
    }
}
