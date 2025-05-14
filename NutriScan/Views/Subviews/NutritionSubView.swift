//
//  NutritionSubView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 3/5/25.
//

import SwiftUI

struct NutritionSubView: View {
    
    let totalFoodWeight: String
    let inputDisable: Bool
    let newCalories: String
    let newProtein: String
    let newFiber: String
    let newFat: String
    
    var body: some View {
        VStack{
            
            HStack {// Display total food weight
                Text("Nutrition")
                Spacer()
                if !inputDisable {
                    Text("Per: \(totalFoodWeight) g")
                }
            }
            .foregroundColor(Color.gray)
            .fontWeight(.bold)
            .font(.caption)
            VStack {
                VStack { // Display Nutritions values
                    
                    HStack{
                        Nutritions(name: "Calories", value: newCalories, iconName: "flame.fill", backgroundColor: .orange)
                        Nutritions(name: "Protein", value: newProtein, iconName: "fork.knife", backgroundColor: .green)
                    }
                    HStack{
                        Nutritions(name: "Fiber", value: newFiber, iconName: "leaf.fill", backgroundColor: .red)
                        Nutritions(name: "Fat", value: newFat, iconName: "drop.circle.fill", backgroundColor: .brown)
                    }
                }
                .padding(.all, 10)
                .background(Color("DefaultRe"))
                .cornerRadius(10)
            }
        }
        .transition(.opacity)
    }
}

