//
//  TodayReivew.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 23/5/25.
//

import SwiftUI

struct TodayReivew: View {
    @State var nutrientData: [String: Double] = [:]
    @State var foodsNotFound: [String] = []
    
    @AppStorage("accountType") var accountType: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "figure.walk")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20, alignment: .leading)
                Text("Overall Review")
                    .font(.system(size: 20, weight: .bold, design: .default))
            }
            .padding(.bottom, 10)
            .foregroundStyle(Color(UIColor.systemGray))
            VStack(alignment: .leading, spacing: 5) {
                Text("You have consumed \(String(format: "%.2f", nutrientData["totalCalories"] ?? 0)) kcal of calories today")
                    .font(.caption)
                
                Text("You have consumed \(String(format: "%.2f", nutrientData["totalProtein"] ?? 0)) grams of protein today")
                    .font(.caption)
                
                Text("You have consumed \(String(format: "%.2f", nutrientData["totalFiber"] ?? 0)) grams of fiber today")
                    .font(.caption)
                
                Text("You have consumed \(String(format: "%.2f", nutrientData["totalFat"] ?? 0)) grams of fat today")
                    .font(.caption)
                
            }
            .padding(.bottom, 20)
            
            if accountType == "free" {
                HStack(alignment: .center, spacing: 4) {
                    Text("Wanna see more insights?")
                        .font(.caption)
                    Image(systemName: "crown.fill")
                        .font(.caption)
                }
                .foregroundStyle(Color("CustomBlue"))
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(Color("InversedPrimary"))
        )
        .onAppear {
            HelperFunctions.getTodayReview { review, foodsNotFound in
                self.nutrientData = review
                self.foodsNotFound = foodsNotFound
            }
        }
    }
}

