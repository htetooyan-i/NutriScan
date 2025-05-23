//
//  SavedView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 14/5/25.
//

import SwiftUI

struct SavedView: View {
    
    @ObservedObject var foodCache = FoodCache.shared
    @State var searchText: String = ""
    @State var sortedKeys: [String] = []

    @State var data: [String: [[String: Any]]] = [:]
    @ObservedObject var userManager = UserManager.shared
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if data.isEmpty {
                    if userManager.isLoggedIn {
                        FoodNotFound(message: "You have nothing to find here, go take some photos of food and comback!", icon: "magnifyingglass") // if data is empty FoodNotFound ui will be shown
                            .padding()
                    }else {
                        FoodNotFound(message: "Saved images will appear here, get snapping. \n Go Login first!", icon: "figure.climbing") // if data is empty FoodNotFound ui will be shown
                            .padding()
                    }
                } else {
                    SavedFoodCards(sortedKeys: sortedKeys, data: data) // if the data is not empty Food Cards will be shown and sorted by its creation date
                }
                
            }
            .navigationTitle("Saved") // Set saved as the title of the saved view
            .searchable(text: $searchText, placement: .automatic, prompt: "Search") // create a search bar to filter the food data
            .background(Color(UIColor.systemGray6))
            .navigationBarTitleDisplayMode(.large)
        }
        .accentColor(Color("CustomBlue"))
        .onAppear {
            if foodCache.isUpdated { // when saved view is appear it will check foodData in foodDatacache has been updated or not. If yes it will use that data to display food cards.
                self.setData()
            }
        }
        .onChange(of: foodCache.isUpdated) { oldValue, newValue in
            if newValue { // If foodData in foodCache has been updated this code will take that foodData and use that data to display food cards.
                self.setData()
            }
        }
        
        .onChange(of: searchText) { oldValue, newValue in
            if newValue != "" { // when value of search bar has been changed this code will chaek that value is empty or not. If empty it won't filter anything.
                (self.data, self.sortedKeys) = HelperFunctions.searchFoods(for: newValue, in: self.data)
            } else { // If not empty it will filter by using user entered text.
                (self.data, self.sortedKeys) = HelperFunctions.sortByDate(for: foodCache.foodDataCache)
            }
        }
    }
    
    func setData() { // this function take foodCacheData from cache file and set it to be able to use in this file.
        let (sorted, keys) = HelperFunctions.sortByDate(for: foodCache.foodDataCache)
        self.data = sorted
        self.sortedKeys = keys
    }
}
