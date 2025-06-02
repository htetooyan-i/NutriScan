//
//  FoodDetailView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 1/6/25.
//

import SwiftUI
import Kingfisher

struct FoodDetailView: View {
    
    @State var foodName: String
    @State var foodConfidence: Double
    @State var foodCalories: String
    @State var foodProtein: String
    @State var foodFat: String
    @State var foodFiber: String
    @State var foodPrice: Double
    @State var foodImgUrl: URL
    @State var foodWeight: String
    @State var foodQuantity: Int
    @State var foodId: String
    
    @State var imageThumb: URL?
    @State var totalFoodWeight: String?
    
    @State var newCalories: String = ""
    @State var newProtein: String = ""
    @State var newFat: String = ""
    @State var newFiber: String = ""
    @State var newPrice: Double?
    @State var newWeight: String = ""
    @State var newQuantity: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    ScrollView {
                        
                        KFImage(foodImgUrl)
                            .placeholder {
                                ProgressView()
                            }
                            .cacheOriginalImage()
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                            .cornerRadius(10)
                        
                        HStack {
                            // MARK: - PREDICTION THUMBNAIL
                            
                            if let thumb = imageThumb{
                                KFImage(thumb)
                                    .placeholder {
                                        ProgressView()
                                    }
                                    .cacheOriginalImage()
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(.circle)
                                
                            } else {
                                Image("FoodNotFound")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(.circle)
                            }
                            // MARK: - FOOD LABEL
                            VStack{
                                Text(foodName.capitalized)
                                    .font(Font.custom("ComicRelief-Bold", size: 20))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack {
                                    ProgressView(value: foodConfidence)
                                        .tint(Color("SecColor"))
                                    Text(String(format: "%.0f%%", (foodConfidence) * 100))
                                        .font(Font.custom("ComicRelief-Regular", size: 15))
                                }
                                
                            }
                            .frame(maxWidth: 150)
                            .padding(.leading, 20)
                            Spacer()
                        }
                        NutritionSubView(
                            totalFoodWeight: totalFoodWeight ?? "0",
                            inputDisable: false,
                            newCalories: newCalories,
                            newProtein: newProtein,
                            newFiber: newFiber,
                            newFat: newFat
                        )
                        WeightSubView(foodWeight: $newWeight, foodQuantity: $newQuantity)
                        PriceSubView(foodPrice: $newPrice, inputDisable: false)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal)
                .padding(.top)
            }
            .onAppear {
                DatabaseModel.getFoodThumbnail(foodName: self.foodName) { imgUrl in
                    if let imgUrl = imgUrl {
                        self.imageThumb = imgUrl
                    }
                }
                self.totalFoodWeight = String(format: "%.1f", (Double(foodWeight) ?? 0) * Double(foodQuantity))
                self.newWeight = self.foodWeight
                self.newQuantity = self.foodQuantity
                self.newPrice = self.foodPrice
                
                let nutrientValues = HelperFunctions.calculateNutrition(
                    baseCalories: Double(foodCalories) ?? 0,
                    baseProtein: Double(foodProtein) ?? 0,
                    baseFiber: Double(foodFiber)  ?? 0,
                    baseFat: Double(foodFat) ?? 0,
                    baseWeight: Double(foodWeight) ?? 0,
                    newWeight: Double(newWeight) ?? 0,
                    baseQuantity: Double(foodQuantity),
                    newQuantity: Double(newQuantity)
                )
                
                newCalories = nutrientValues.calories
                newProtein = nutrientValues.protein
                newFiber = nutrientValues.fiber
                newFat = nutrientValues.fat
            }
            
            .onChange(of: newPrice) { oldValue, newValue in
                
                HelperFunctions.updateFoodDataInDatabase(
                    user: UserManager.shared.userId,
                    collectionName: "foods",
                    updateId: foodId,
                    updateArray: [
                        "foodPrice": newPrice ?? 0
                    ]
                )
                
                HelperFunctions.getFoodDataFromDatabase(user: UserManager.shared.userId, collectionName: "foods")
            }
            
            .onChange(of: newWeight) { oldValue, newValue in
                
                let nutrientValues = HelperFunctions.calculateNutrition(
                    baseCalories: Double(foodCalories) ?? 0,
                    baseProtein: Double(foodProtein) ?? 0,
                    baseFiber: Double(foodFiber)  ?? 0,
                    baseFat: Double(foodFat) ?? 0,
                    baseWeight: Double(foodWeight) ?? 0,
                    newWeight: Double(newWeight) ?? 0,
                    baseQuantity: Double(foodQuantity),
                    newQuantity: Double(newQuantity)
                )
                
                newCalories = nutrientValues.calories
                newProtein = nutrientValues.protein
                newFiber = nutrientValues.fiber
                newFat = nutrientValues.fat
                
                HelperFunctions.updateFoodDataInDatabase(
                    user: UserManager.shared.userId,
                    collectionName: "foods",
                    updateId: foodId,
                    updateArray:  [
                        "foodWeight": newWeight,
                        "foodCalories": newCalories,
                        "foodProtein": newProtein,
                        "foodFiber": newFiber,
                        "foodFat": newFat,
                    ]
                )
                
                HelperFunctions.getFoodDataFromDatabase(user: UserManager.shared.userId, collectionName: "foods")
            }
            
            .onChange(of: newQuantity) { oldValue, newValue in
                
                let nutrientValues = HelperFunctions.calculateNutrition(
                    baseCalories: Double(foodCalories) ?? 0,
                    baseProtein: Double(foodProtein) ?? 0,
                    baseFiber: Double(foodFiber)  ?? 0,
                    baseFat: Double(foodFat) ?? 0,
                    baseWeight: Double(foodWeight) ?? 0,
                    newWeight: Double(newWeight) ?? 0,
                    baseQuantity: Double(foodQuantity),
                    newQuantity: Double(newQuantity)
                )
                
                newCalories = nutrientValues.calories
                newProtein = nutrientValues.protein
                newFiber = nutrientValues.fiber
                newFat = nutrientValues.fat
                
                HelperFunctions.updateFoodDataInDatabase(
                    user: UserManager.shared.userId,
                    collectionName: "foods",
                    updateId: foodId,
                    updateArray:  [
                        "foodQuantity": newQuantity,
                        "foodCalories": newCalories,
                        "foodProtein": newProtein,
                        "foodFiber": newFiber,
                        "foodFat": newFat,
                    ]
                )
                
                HelperFunctions.getFoodDataFromDatabase(user: UserManager.shared.userId, collectionName: "foods")
            }
        }
    }
}
