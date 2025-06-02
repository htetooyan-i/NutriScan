//
//  QuickSummaryStats.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 2/6/25.
//

import SwiftUI

struct QuickSummaryStats: View {
    @State var iconName: String
    @State var statName: String
    @Binding var statValue: Double
    @State var color: Color
    @State var unit: String
    
    var body: some View {
        HStack {
            // IDEA: Display Nutrition Icon Such as Calorie Protein Fat and Fiber
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(color)
                .padding(.all, 5)
            
            Text(statName)
                .font(Font.custom("ComicRelief-Bold", size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            HStack {
                let value = String(format: "%.2f", statValue)
                
                Text(statName == "Price" ? "\(unit) \(value)" : "\(value) \(unit)")
                    .font(Font.custom("ComicRelief-Regular", size: 15))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)

    }
}

