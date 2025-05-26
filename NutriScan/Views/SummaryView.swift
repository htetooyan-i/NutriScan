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
    @ObservedObject var userManager = UserManager.shared
    
    var body: some View {
        if userManager.isLoggedIn {
            NavigationStack {
                ZStack {
                    Color(UIColor.systemGray6)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            NavigationLink {
                                OverallDetail()
                            } label: {
                                TodayReivew()
                            }

                            
                            NutrientNaviLink(iconName: "flame.fill", iconColor: Color.orange, name: "Calories", unit: "kcal")
                            
                            NutrientNaviLink(iconName: "fork.knife", iconColor: Color.green, name: "Protein", unit: "g")
                            
                            NutrientNaviLink(iconName: "leaf.fill", iconColor: Color.red, name: "Fiber", unit: "g")
                            
                            NutrientNaviLink(iconName: "drop.circle.fill", iconColor: Color.brown, name: "Fat", unit: "g")
                            
                            NavigationLink {
                                SummaryStats(statName: "Price", statIcon: "dollarsign.circle", statColor: Color.customBlue, unit: "$")
                            } label: {
                                PriceStats()
                            }

                        }
                        .padding()
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                    
                    
                    
                }
                .navigationTitle("Summary")
                .navigationBarTitleDisplayMode(.large)
            }
            .accentColor(Color("CustomBlue"))
        } else {
            FoodNotFound(message: "Food stats will appear here, start recording to see your progress!", icon: "figure.baseball")
                .padding()
        }
    }
}

#Preview {
    SummaryView()
}
