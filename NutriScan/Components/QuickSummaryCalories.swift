//
//  QuickSummaryCalories.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 3/6/25.
//

import SwiftUI

struct QuickSummaryCalories: View {
    
    @Binding var calories: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center,spacing: 10) {
                Image(systemName: "chart.xyaxis.line")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.orange)
                    .fontWeight(.bold)
                Text("Total")
            }
            QuickSummaryStats(iconName: "flame.fill", statName: "Calories", statValue: $calories, color: .orange, unit: "kcal")
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(Color("InversedPrimary"))
        )
        
    }
}
