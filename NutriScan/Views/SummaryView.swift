//
//  SummaryView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 21/5/25.
//

import SwiftUI
import Charts

struct SummaryView: View {

    @ObservedObject var userManager = UserManager.shared
    @ObservedObject var userCache = UserCache.shared
    @ObservedObject var foodCache = FoodCache.shared
    
    @State private var personalInfo: PersonalInfo? = nil
    @State private var foodInfo: [String: [[String: Any]]] = [:]
    
    var body: some View {
        if userManager.isLoggedIn {
            NavigationStack {
                ZStack {
                    Color(UIColor.systemGray6)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            NavigationLink {
                                OverallDetail(personalInfo: personalInfo, foodInfo: foodInfo)
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
            .onAppear {
                if foodCache.isUpdated && !userCache.isLoading {
                    self.personalInfo = userCache.personalInfo
                    self.foodInfo = foodCache.foodDataCache
                }
            }
            .onChange(of: foodCache.isUpdated, { oldValue, newValue in
                if newValue {
                    if foodCache.isUpdated && !userCache.isLoading {
                        self.personalInfo = userCache.personalInfo
                        self.foodInfo = foodCache.foodDataCache
                    }
                }
            })
        } else {
            FoodNotFound(message: "Food stats will appear here, start recording to see your progress!", icon: "figure.baseball")
                .padding()
        }
    }
}

