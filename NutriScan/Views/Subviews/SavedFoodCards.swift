//
//  SavedFoodCards.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 16/5/25.
//

import SwiftUI

struct SavedFoodCards: View {
    let sortedKeys: [String]
    let data: [String: [[String: Any]]]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    @Binding var selectedFoods: [String]
    @Binding var isSelectionMode: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(sortedKeys, id: \.self) { date in
                Text(date)
                    .font(.system(size: 20, weight: .bold))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                LazyVGrid(columns: columns, spacing: 20) {
                    if let foods = data[date] {
                        ForEach(Array(foods.enumerated()), id: \.offset) { idx, food in
                            if let foodName = food["SelectedFood"] as? String,
                               let predictions = food["foodPredictions"] as? [String: Double],
                               let predictionConfidence = predictions[foodName],
                               let urlString = food["imageURL"] as? String,
                               let imageURL = URL(string: urlString),
                               let foodCalories = food["foodCalories"] as? String,
                               let foodProtein = food["foodProtein"] as? String,
                               let foodFat = food["foodFat"] as? String,
                               let foodFiber = food["foodFiber"] as? String,
                               let foodPrice = food["foodPrice"] as? Double,
                               let foodWeight = food["foodWeight"] as? String,
                               let foodQuantity = food["foodQuantity"] as? Int,
                               let foodId = food["foodId"] as? String {

                                let foodCard = FoodCard(
                                    imageURL: imageURL,
                                    foodName: foodName,
                                    predictionConfidence: predictionConfidence
                                ).id(foodId)

                                if isSelectionMode {
                                    foodCard
                                        .overlay(
                                            selectedFoods.contains(foodId) ?
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color("PriColor"), lineWidth: 3)
                                                        .background(Color(UIColor.systemGray).opacity(0.2))
                                                        .cornerRadius(12)

                                                    Image(systemName: "checkmark.circle.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 24, height: 24)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                                        .padding(8)
                                                        .foregroundStyle(Color("PriColor"))
                                                } : nil
                                        )
                                        .onTapGesture {
                                            if selectedFoods.contains(foodId) {
                                                selectedFoods.removeAll { $0 == foodId }
                                            } else {
                                                selectedFoods.append(foodId)
                                            }
                                        }
                                } else {
                                    NavigationLink {
                                        FoodDetailView(
                                            foodName: foodName,
                                            foodConfidence: predictionConfidence,
                                            foodCalories: foodCalories,
                                            foodProtein: foodProtein,
                                            foodFat: foodFat,
                                            foodFiber: foodFiber,
                                            foodPrice: foodPrice,
                                            foodImgUrl: imageURL,
                                            foodWeight: foodWeight,
                                            foodQuantity: foodQuantity,
                                            foodId: foodId
                                        )
                                    } label: {
                                        foodCard
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
