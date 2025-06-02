//
//  QuickSummaryStats.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 2/6/25.
//

import SwiftUI

struct QuickSummaryStats: View {
    var body: some View {
        HStack {
            // IDEA: Display Nutrition Icon Such as Calorie Protein Fat and Fiber
            Image(systemName: "flame.fill")
                .font(.title2)
                .foregroundColor(.orange)
                .padding(.all, 5)
            
            Text("Calories")
                .font(Font.custom("ComicRelief-Bold", size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            HStack {
                Text("\("30" ?? "0") \("30" == "N/A" ? "" : "kcal")")
                    .font(Font.custom("ComicRelief-Regular", size: 15))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .background(Color("ForColor"))
        .cornerRadius(10)
    }
}

#Preview {
    QuickSummaryStats()
}
