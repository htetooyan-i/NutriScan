//
//  SummaryStats.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 21/5/25.
//

import SwiftUI
import Charts

struct SummaryStats: View {
    
    let data = [("Jan", 3), ("Feb", 2), ("Mar", 9),("Apr", 3), ("May", 2), ("Jun", 9), ("Jul", 3), ("Aug", 2), ("Sep", 9)]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack {
                    VStack(alignment: .leading) {
                        Chart {
                            ForEach(data, id: \.0) { month, value in
                                LineMark(
                                    x: .value("Month", month),
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
                            Image(systemName: "flame.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding(5)
                                .foregroundStyle(Color.orange)
//                                .background(
//                                    Circle()
//                                        .fill(Color("SecColor"))
//                                )
                            Text("Calories Stats")
                                .font(.custom("ComicRelief-Bold", size: 20))
                            
                        }
                        .padding(.bottom, 20)
                        
                        VStack {
                            HStack {
                                Text("Firday 12, May 2024 ")
                                Spacer()
                                Text("1023 Kcal")
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(Color(UIColor.systemGray6))
                            )
                            
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
            .navigationTitle("Calories")
        }
    }
}

#Preview {
    SummaryStats()
}
