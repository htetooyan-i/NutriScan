//
//  FoodListView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 19/5/25.
//

import SwiftUI

struct FoodListView: View { // show the all foods that is available for this model
    @State var foodList: [String] = []
    @State var filteredFoodList: [String] = []
    @State var searchText: String = ""
    var body: some View {
        NavigationStack(root: {
            List(filteredFoodList, id: \.self) { food in
                Text(food)
            }
            .navigationTitle("Available Food List")
            .searchable(text: $searchText, prompt: "Search Foods")
        })
        .onAppear {
            self.foodList = HelperFunctions.getAvailableFoodList()
            self.filteredFoodList = foodList
        }
        
        .onChange(of: searchText) { oldValue, newValue in
            filterFoods()
        }
        
    }
    
    private func filterFoods() {
        filteredFoodList = []
        
        for food in foodList {
            if food.lowercased().contains(searchText.lowercased()) {
                filteredFoodList.append(food)
            }
        }
    }
}

