//
//  FoodDetailView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 1/6/25.
//

import SwiftUI
import Kingfisher

struct FoodDetailView: View {

    @State var foodId: String
    @State var foodName: String
    @State var foodConfidence: Double
    @State var foodImgUrl: URL
    
    @State var foodData: FoodData?

    @State var imageThumb: URL?
    @State var totalFoodWeight: String?
    
    @State var newCalories: String = ""
    @State var newProtein: String = ""
    @State var newFat: String = ""
    @State var newFiber: String = ""
    @State var newPrice: Double?
    @State var newWeight: String = ""
    @State var newQuantity: Int = 0
    @State private var hasAppeared = false

    
    @State var priceInputDisable: Bool = true
    @StateObject var foodCache = FoodCache.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    ScrollView {
                        VStack {
                            // MARK: - User Taken Image
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
                                // MARK: - Food Thumbnail
                                
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
                            
                            // MARK: - Nutrition View
                            
                            NutritionSubView(
                                totalFoodWeight: totalFoodWeight ?? "0",
                                inputDisable: false,
                                newCalories: newCalories,
                                newProtein: newProtein,
                                newFiber: newFiber,
                                newFat: newFat
                            )
                            
                            // MARK: - Weight And Quantity View
                            
                            WeightFormSubView(foodWeight: $newWeight, foodQuantity: $newQuantity)
                            
                            // MARK: - Price View
                            
                            PriceFormSubView(foodPrice: $newPrice, inputDisable: $priceInputDisable)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .onAppear {
                if foodCache.isUpdated {
                    self.foodData = getFoodData(for: foodId)
                    if let food = self.foodData {
                        DatabaseModel.getFoodThumbnail(foodName: food.SelectedFood) { imgUrl in
                            if let imgUrl = imgUrl {
                                self.imageThumb = imgUrl
                            }
                        }
                        self.totalFoodWeight = String(format: "%.1f", (Double(food.foodWeight) ?? 0) * Double(food.foodQuantity))
                        self.newWeight = food.foodWeight
                        self.newQuantity = food.foodQuantity
                        self.newPrice = food.foodPrice
                        
                        calculateNutrientValues()
                    }
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    hasAppeared = true
                }
                
            }
            
            .onChange(of: foodCache.isUpdated, { oldValue, newValue in
                if newValue {
                    self.foodData = getFoodData(for: foodId)
                    if let food = self.foodData {
                        DatabaseModel.getFoodThumbnail(foodName: food.SelectedFood) { imgUrl in
                            if let imgUrl = imgUrl {
                                self.imageThumb = imgUrl
                            }
                        }
                        self.totalFoodWeight = String(format: "%.1f", (Double(food.foodWeight) ?? 0) * Double(food.foodQuantity))
                        self.newWeight = food.foodWeight
                        self.newQuantity = food.foodQuantity
                        self.newPrice = food.foodPrice
                        
                        calculateNutrientValues()
                    }
                }
            })
            
            .onChange(of: newPrice) { oldValue, newValue in
                
                guard hasAppeared else { return }
                
                updateAndGetFoodData(dataArray: [
                    "foodPrice": newPrice ?? 0
                ])
            }
            
            .onChange(of: newWeight) { oldValue, newValue in
                
                guard hasAppeared else { return }
                
                calculateNutrientValues()
                
                updateAndGetFoodData(dataArray: [
                    "foodWeight": newWeight,
                    "foodCalories": newCalories,
                    "foodProtein": newProtein,
                    "foodFiber": newFiber,
                    "foodFat": newFat,
                ])
            }
            
            .onChange(of: newQuantity) { oldValue, newValue in
                
                guard hasAppeared else { return }
                
                calculateNutrientValues()
                
                updateAndGetFoodData(dataArray: [
                    "foodQuantity": newQuantity,
                    "foodCalories": newCalories,
                    "foodProtein": newProtein,
                    "foodFiber": newFiber,
                    "foodFat": newFat,
                ])
            }
        }
    }
    
    private func getFoodData(for foodId: String) -> FoodData? {
        let foods = FoodCache.shared.foodDataCache
        
        for food in foods {
            if food.foodId == foodId {
                return food
            }
        }
        return nil
    }
        
    
    private func calculateNutrientValues() {
        if let food = self.foodData {
            let nutrientValues = HelperFunctions.calculateNutrition(
                baseCalories: Double(food.foodCalories) ?? 0,
                baseProtein: Double(food.foodProtein) ?? 0,
                baseFiber: Double(food.foodFiber)  ?? 0,
                baseFat: Double(food.foodFat) ?? 0,
                baseWeight: Double(food.foodWeight) ?? 0,
                newWeight: Double(newWeight) ?? 0,
                baseQuantity: Double(food.foodQuantity),
                newQuantity: Double(newQuantity)
            )
            
            newCalories = nutrientValues.calories
            newProtein = nutrientValues.protein
            newFiber = nutrientValues.fiber
            newFat = nutrientValues.fat
        }
    }
    
    private func updateAndGetFoodData(dataArray: [String: Any]) {
        HelperFunctions.updateFoodDataInDatabase(
            user: UserManager.shared.userId,
            collectionName: "foods",
            updateId: foodId,
            updateArray: dataArray
        )
        
        HelperFunctions.getFoodDataFromDatabase(user: UserManager.shared.userId, collectionName: "foods")
    }
}
