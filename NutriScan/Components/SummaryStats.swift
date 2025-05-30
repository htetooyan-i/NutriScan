//
//  SummaryStats.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 21/5/25.
//

import SwiftUI
import Charts

struct SummaryStats: View {
    
    @State var data: [String : Double] = [:]
    @State var sortedDate: [String] = []
    @State var statName: String
    @State var statIcon: String
    @State var statColor: Color
    @State var unit: String
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack {
                    VStack(alignment: .leading) {
                        Chart {
                            ForEach(sortedDate, id: \.self) { date in
                                if let value = self.data[date] {
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
                    
                    StatsList(statIcon: self.statIcon, statColor: self.statColor, data: $data, statName: self.statName, unit: self.unit)
                    
                    
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                
            }
            .navigationTitle(statName)
        }
        
        .onAppear {
            switch statName {
            case "Calories":
                self.data = HelperFunctions.getStatsTotal(for: FoodCache.shared.caloriesDataCache)
            case "Protein":
                self.data = HelperFunctions.getStatsTotal(for: FoodCache.shared.proteinDataCache)
            case "Fiber":
                self.data = HelperFunctions.getStatsTotal(for: FoodCache.shared.fiberDataCache)
            case "Fat":
                self.data = HelperFunctions.getStatsTotal(for: FoodCache.shared.fatDataCache)
            case "Price":
                self.data = HelperFunctions.getStatsTotal(for: FoodCache.shared.priceDataCache)
            default:
                break
            }
            print(self.data)
            
            self.sortedDate = HelperFunctions.sortStatsByDate(for: self.data)
        }
    }
}

