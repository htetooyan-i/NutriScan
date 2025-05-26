//
//  PriceStats.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 24/5/25.
//

import SwiftUI
import Charts

struct PriceStats: View {
    @State var data: [String: Double] = [:]
    @State var sortedDate: [String] = []
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(5)
                    .foregroundStyle(Color.customBlue)
                Text("Price Stats")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundStyle(Color(UIColor.systemGray))
                Spacer()
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading) {
                Chart {
                    ForEach(sortedDate, id: \.self) { date in
                        if let value = data[date] {
                            let formattedDate = HelperFunctions.dateFormatter(timeString: date, format: "MMMM dd")
                            LineMark(
                                x: .value("day", formattedDate),
                                y: .value("Value", value)
                            )
                            PointMark(
                                x: .value("day", formattedDate),
                                y: .value("Value", value)
                            )
                        }
                    }
                    
                    
                }
                .frame(height: 300)
            }
            .padding(.all, 10)
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color("InversedPrimary"))
            )
            
            HStack(alignment: .center, spacing: 4) {
                Text("Wanna see more insights?")
                    .font(.caption)
                Image(systemName: "crown.fill")
                    .font(.caption)
            }
            .foregroundStyle(Color("CustomBlue"))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.vertical)
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(Color.inversedPrimary)
        )
        .onAppear {
            self.data = HelperFunctions.getStatsTotal(for: FoodCache.shared.priceDataCache)
            self.sortedDate = HelperFunctions.sortStatsByDate(for: self.data)
        }
    }
}
