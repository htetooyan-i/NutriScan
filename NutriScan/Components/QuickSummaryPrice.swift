//
//  QuickSummaryPrice.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 3/6/25.
//

import SwiftUI

struct QuickSummaryPrice: View {
    
    @Binding var price: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center,spacing: 10) {
                Image(systemName: "chart.xyaxis.line")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color("PriColor"))
                    .fontWeight(.bold)
                Text("Price")
            }
            QuickSummaryStats(iconName: "dollarsign.circle", statName: "Price", statValue: $price, color: Color.pri, unit: "$")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(Color("InversedPrimary"))
        )
        
    }
}
