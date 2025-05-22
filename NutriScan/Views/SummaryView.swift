//
//  SummaryView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 21/5/25.
//

import SwiftUI
import Charts

struct SummaryView: View {
    
    let data = [("Jan", 3), ("Feb", 2), ("Mar", 9),("Apr", 3), ("May", 2), ("Jun", 9), ("Jul", 3), ("Aug", 2), ("Sep", 9)]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "figure.walk")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .leading)
                            Text("Today Feedback")
                                .font(.system(size: 20, weight: .bold, design: .default))
                        }
                        .padding(.bottom, 10)
                        .foregroundStyle(Color(UIColor.systemGray))
                        VStack(spacing: 5) {
                            Text("You have consumed 1200 calories today")
                                .font(.caption)
                            Text("You have consumed 1200 calories today")
                                .font(.caption)
                            Text("You have consumed 1200 calories today")
                                .font(.caption)
                        }
                        .padding(.bottom, 20)
                        
                        HStack(alignment: .center, spacing: 4) {
                            Text("Wanna see more insights?")
                                .font(.caption)
                            Image(systemName: "crown.fill")
                                .font(.caption)
                        }
                        .foregroundStyle(Color("CustomBlue"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color("InversedPrimary"))
                    )
                    
                    NutrientNaviLink(iconName: "flame.fill", iconColor: Color.orange, name: "Calories")
                    NutrientNaviLink(iconName: "fork.knife", iconColor: Color.green, name: "Protein")
                    NutrientNaviLink(iconName: "leaf.fill", iconColor: Color.red, name: "Fiber")
                    NutrientNaviLink(iconName: "drop.circle.fill", iconColor: Color.brown, name: "Fat")
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                
            }
            .navigationTitle("Summary")
        }
        .accentColor(Color("CustomBlue"))
    }
}

#Preview {
    SummaryView()
}
