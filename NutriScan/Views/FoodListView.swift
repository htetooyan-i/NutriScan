//
//  FoodListView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 19/5/25.
//

import SwiftUI

struct FoodListView: View { // show the all foods that is available for this model
    @State var foodList: [String] = []
    var body: some View {
        List(foodList, id: \.self) { food in
            Text(food)
        }
        .navigationTitle("Available Food List")
        .onAppear {
            self.foodList = HelperFunctions.getAvailableFoodList()
        }
        
    }
}

#Preview {
    FoodListView()
}
