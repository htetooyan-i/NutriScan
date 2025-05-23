//
//  SheetView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 29/4/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import CoreML
import Vision

struct SheetView: View {
    
    @ObservedObject var results: ClassificationModel
    @ObservedObject var nutritionData: NutritionModel
    @ObservedObject var cameraData: CameraModel
    @State var foodWeight: String = ""
    @State var foodQuantity: Int = 0
    @State var newCalories = ""
    @State var newProtein = ""
    @State var newFiber = ""
    @State var newFat = ""
    @State var saved = false
    @State var foodPrice: Double?
    @State var totalFoodWeight: String = ""
    @State var inputDisable: Bool = false
    @Binding var currentDataId: String?
    @State var selectedFood: VNClassificationObservation?
    @ObservedObject var userModel = UserManager.shared
    
    var body: some View {
        if results.predictions.isEmpty || nutritionData.isLoading {
            // MARK: - DATA HAS BEEN DECODING FROM JSON TO DATA
            ProgressView()
        }
        // MARK: - DATA HAVE BEEN DECODED
        else {
            ScrollViewReader(content: { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Color.clear.frame(height: 0).id("top")
                        if results.predictions[0].confidence > 0.3 {
                            // MARK: - FOOD HAS BEEN FOUND
                            VStack(spacing: 20){
                                MainPredictionSubView(selectedFood: selectedFood, results: results, saved: $saved, nutritionData: nutritionData)
                                
                                NavigationSubView(
                                    foodQuantity: $foodQuantity,
                                    foodWeight: $foodWeight,
                                    foodPrice: $foodPrice,
                                    selectedFood: $selectedFood,
                                    results: results,
                                    nutritionData: nutritionData,
                                    totalFoodWeight: totalFoodWeight,
                                    inputDisable: inputDisable,
                                    newCalories: newCalories,
                                    newProtein: newProtein,
                                    newFiber: newFiber,
                                    newFat: newFat)
                            }
                        }
                        // MARK: - FOOD NOT FOUND
                        else {
                            VStack {
                                Image("FoodNotFound")
                                    .padding()
                                Text("No Food DETECTED")
                                    .foregroundColor(Color("SecColor"))
                                    .font(.headline)
                                
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                    .padding(.all)
                    .onAppear {
                        proxy.scrollTo("top", anchor: .top)
                        // set highet confidence prediciton as selected Food
                        if selectedFood == nil {
                            selectedFood = results.predictions.first
                        }
                        // set base food weight and food quantity which have been gotten from nutiriton api
                        foodWeight = String(nutritionData.nutrientInfo[selectedFood?.identifier ?? ""]?["serving_weight_grams"] as? Int ?? 0)
                        foodQuantity = nutritionData.nutrientInfo[selectedFood?.identifier ?? ""]?["serving_qty"] as? Int ?? 0
                        
                        // calculate total food wieght by multipling food weight and food quantity to display
                        totalFoodWeight = String(Int((Double(foodWeight) ?? 0) * Double(foodQuantity)))
                        
                        // TODO: When nutrition values are not valid(In this case "N/A") need to disable input field such as food weigth, food quantity and food price.
                        inputDisable = totalFoodWeight == "0" ? true : false
                        
                        // Call nutrition calculator function to calculate nutrition values base on current data
                        callNutritionFunction()
                        print("InSheetView: \(newCalories)")
                        
                    }
                    .onDisappear(perform: {
                        selectedFood = nil
                    })
                    .onChange(of: foodWeight) { oldValue, newValue in
                        // Call nutrition calculator function to calculate nutrition values base on current food weight
                        callNutritionFunction()
                        
                        // If current prediction has been saved and user change the food weight value, food weight value in the database also has to be changed
                        if saved {
                            HelperFunctions.updateFoodDataInDatabase(
                                user: userModel.userId,
                                collectionName: "foods",
                                updateId: currentDataId!,
                                updateArray:  [
                                    "foodWeight": foodWeight,
                                    "foodCalories": newCalories,
                                    "foodProtein": newProtein,
                                    "foodFiber": newFiber,
                                    "foodFat": newFat,
                                ]
                            )
                        }
                    }
                    
                    .onChange(of: foodQuantity) { oldValue, newValue in
                        
                        // Set foodWeight to zero when food weight input field is empty
                        if foodWeight == "" {
                            foodWeight = String(nutritionData.nutrientInfo[selectedFood?.identifier ?? ""]?["serving_weight_grams"] as? Int ?? 0)
                        }
                        
                        // Call nutrition calculator function to calculate nutrition values base on current food quantity
                        callNutritionFunction()
                        
                        // If current prediction has been saved and user change the food quantity value, food quantity value in the database also has to be changed
                        if saved {
                            HelperFunctions.updateFoodDataInDatabase(
                                user: userModel.userId,
                                collectionName: "foods",
                                updateId: currentDataId!,
                                updateArray:  [
                                    "foodQuantity": foodQuantity,
                                    "foodCalories": newCalories,
                                    "foodProtein": newProtein,
                                    "foodFiber": newFiber,
                                    "foodFat": newFat,
                                ]
                            )
                        }
                    }
                    
                    .onChange(of: saved) { oldValue, newValue in
                        // When user save the current prediction, data need to be stored in database
                        if saved {
                            HelperFunctions.createFoodDataInDatabase(
                                results: results,
                                user: userModel.userId,
                                collectionName: "foods",
                                takenPicData: cameraData.picData,
                                dataArray: [
                                    "SelectedFood": selectedFood?.identifier ?? "No Prediction",
                                    "foodCalories": newCalories,
                                    "foodProtein": newProtein,
                                    "foodFiber": newFiber,
                                    "foodFat": newFat,
                                    "foodWeight": foodWeight,
                                    "foodQuantity": foodQuantity,
                                    "foodPrice": foodPrice ?? 0.0
                                ]
                            ) { dataId in
                                if let id = dataId {
                                    print("Saved with ID: \(id)")
                                    currentDataId = id
                                    HelperFunctions.getFoodDataFromDatabase(user: userModel.userId, collectionName: "foods")
                                } else {
                                    print("Save failed")
                                }
                            }
                        
                        // When user unsave the current prediction, data inside the database need to be deleted
                        } else {
                            HelperFunctions.deleteFoodDataFromDatabase(
                                currentDataId: currentDataId,
                                user: userModel.userId,
                                collectionName: "foods") { isDeleted in
                                    if isDeleted {
                                        currentDataId = nil
                                    }
                                }
                        }
                    }
                    // If current prediction has been saved and user change the food price value, food price value in the database also has to be changed
                    .onChange(of: foodPrice) { oldValue, newValue in
                        if saved{
                            HelperFunctions.updateFoodDataInDatabase(
                                user: userModel.userId,
                                collectionName: "foods",
                                updateId: currentDataId!,
                                updateArray: [
                                    "foodPrice": foodPrice ?? 0.0
                                ]
                            )
                        }
                    }
                    
                    // If user change the selected Food, nutrition data need to be calculated again base on new food data. So function that calculate nutrition data need to be called again
                    .onChange(of: selectedFood) { oldValue, newValue in
                        callNutritionFunction()
                    }
                }
            })
            .scrollDisabled(true)

        }
    }
    
    // MARK: - FUNCTION TO CALL NUTRITION FUNCITON DUE TO ITS LONG PARAMETERS
    func callNutritionFunction() {
        // IDEA: CalculateNutrition function from helper function return tuple so need to recieve with one variable and then set to each variable
        let nutrientValues = HelperFunctions.calculateNutrition(
            baseCalories: nutritionData.nutrientInfo[selectedFood?.identifier ?? ""]?["nf_calories"] as? Double ?? 0,
            baseProtein: nutritionData.nutrientInfo[selectedFood?.identifier ?? ""]?["nf_protein"] as? Double ?? 0,
            baseFiber: nutritionData.nutrientInfo[selectedFood?.identifier ?? ""]?["nf_dietary_fiber"] as? Double ?? 0,
            baseFat: nutritionData.nutrientInfo[selectedFood?.identifier ?? ""]?["nf_total_fat"] as? Double ?? 0,
            baseWeight: Double(nutritionData.nutrientInfo[selectedFood?.identifier ?? ""]?["serving_weight_grams"] as? Int ?? 0),
            newWeight: Double(foodWeight) ?? 0,
            baseQuantity: Double(nutritionData.nutrientInfo[selectedFood?.identifier ?? ""]?["serving_qty"] as? Int ?? 0),
            newQuantity: Double(foodQuantity))
        
        newCalories = nutrientValues.calories
        newProtein = nutrientValues.protein
        newFiber = nutrientValues.fiber
        newFat = nutrientValues.fat
    }
}
