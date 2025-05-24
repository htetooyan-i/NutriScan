//
//  SummaryStats.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 21/5/25.
//

import SwiftUI
import Charts

struct SummaryStats: View {
    
    @State var data: [String : Double]?
    @State var nutrientName: String
    @State var nutrientIcon: String
    @State var nutrientColor: Color
    @State var unit: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack {
                    VStack(alignment: .leading) {
                        Chart {
                            ForEach(Array(data ?? [:]), id: \.key) { day, value in
                                LineMark(
                                    x: .value("day", day),
                                    y: .value("Value", value)
                                )
                                PointMark(
                                    x: .value("day", day),
                                    y: .value("Value", value)
                                )
                            }
                        }
                        .frame(height: 300)
                    }
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color("InversedPrimary"))
                    )
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 20) {
                            Image(systemName: nutrientIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding(5)
                                .foregroundStyle(nutrientColor)
                            Text("\(nutrientName) Stats")
                                .font(.custom("ComicRelief-Bold", size: 20))
                            
                        }
                        .padding(.bottom, 20)
                        
                        VStack {
                            ForEach(Array(data ?? [:]), id: \.key) { date, value in
                                NavigationLink {
                                    NutrientStatsList(date: date, nutrientName: nutrientName, unit: unit)
                                } label: {
                                    HStack {
                                        Text(date)
                                        Spacer()
                                        Text(String(format: "%.2f %@", value, unit))
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
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color("InversedPrimary"))
                    )
                    .frame(maxWidth: .infinity)
                    
                    
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                
            }
            .navigationTitle(nutrientName)
        }
        
        .onAppear {
            switch nutrientName {
            case "Calories":
                self.data = HelperFunctions.getStatsTotal(for: FoodCache.shared.caloriesDataCache)
            case "Protein":
                self.data = HelperFunctions.getStatsTotal(for: FoodCache.shared.proteinDataCache)
            case "Fiber":
                self.data = HelperFunctions.getStatsTotal(for: FoodCache.shared.fiberDataCache)
            case "Fat":
                self.data = HelperFunctions.getStatsTotal(for: FoodCache.shared.fatDataCache)
            default:
                break
            }
        }
    }
}

