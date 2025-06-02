//
//  QuickSummaryView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 2/6/25.
//

import SwiftUI

struct FoodNutrient: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
    let color: Color
}

struct SelectedFoods: Identifiable {
    let id = UUID()
    let name: String
    let thumbnail: URL
}

struct QuickSummaryView: View {
    
    
    @Binding var showSummary: Bool
    @Binding var selectedFoodIds: [String]
    
    @State var showSelectedFoods: Bool = false
    @State var foodData: [FoodData] = []

    @State private var calories: Double = 0
    @State private var protein: Double = 0
    @State private var fiber: Double = 0
    @State private var fat: Double = 0
    @State private var price: Double = 0
    
    @State private var foodNutrients: [FoodNutrient] = []
    @State private var selectedFoods: [SelectedFoods] = []
    
    
    var body: some View {
        VStack {
            // MARK: - Title and close btn
            HStack {
                Text("Quick Summary")
                    .font(.system(size: 30, weight: .bold, design: .default))
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color(UIColor.systemGray))
                    .onTapGesture {
                        self.showSummary = false
                    }
            }
            .padding()
            
            ScrollView() {
                
                VStack(spacing: 20) {
                    // MARK: - Price Section
                    
                    QuickSummaryPrice(price: $price)
                    
                    // MARK: - Calories Section
                    
                    QuickSummaryCalories(calories: $calories)
                    
                    // MARK: - Macros Section
                    
                    QuickSummaryMacros(protein: $protein, fiber: $fiber, fat: $fat)
                    
                    // MARK: - Macros Pie Chart Section
                    
                    QuickSummaryPieChart(foodNutrients: $foodNutrients)
                    
                    // MARK: - Selected Foods Section
                    
                    QuickSummarySelectedFoods(selectedFoods: $selectedFoods, showSelectedFoods: $showSelectedFoods)
                    
                }
            }
            .padding()
        }
        .background(
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
        )
        .onAppear {
            HelperFunctions.getSelectedFoodData(selectedFoodIds: selectedFoodIds) { foodData in
                if let data = foodData {
                    self.foodData = data
                    let nutrients = HelperFunctions.getTotalNutrients(for: self.foodData)

                    self.calories = nutrients.calories
                    self.protein = nutrients.protein
                    self.fiber = nutrients.fiber
                    self.fat = nutrients.fat
                    self.price = HelperFunctions.getTotalPrice(for: self.foodData)
                    
                    let nutrientPercentage = HelperFunctions.calcuateNutrientPercentage(for: nutrients)

                    self.foodNutrients = [
                        FoodNutrient(name: "Protein", value: nutrientPercentage.protein , color: .green),
                        FoodNutrient(name: "Fiber", value: nutrientPercentage.fiber , color: .red),
                        FoodNutrient(name: "Fat", value: nutrientPercentage.fat , color: .brown)
                        
                    ]
                    
                    Task {
                        let thumbnails = await getFoodThumbnails(for: self.foodData)
                        self.selectedFoods = thumbnails
                        print(thumbnails)
                    }
                    
                }
            }
        }
        
    }
    
    func getFoodThumbnails(for foods: [FoodData]) async -> [SelectedFoods] {
        var selectedFoods: [SelectedFoods] = []

        for food in foods {
            let foodName = food.SelectedFood
            if let url = await HelperFunctions.getFoodThumbnail(for: foodName) {
                selectedFoods.append(SelectedFoods(name: foodName, thumbnail: url))
            }
        }

        return selectedFoods
    }


}
