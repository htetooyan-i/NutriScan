//
//  ContentView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 25/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .scan
    
    enum Tab {
        case account, summary, scan, saved, recipes
    }

    var body: some View {
        TabView(selection: $selectedTab) { // Bind the selection to selectedTab
            MainNavigationView(currentTab: .account)
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
                .tag(Tab.account)
            
            MainNavigationView(currentTab: .summary)
                .tabItem {
                    Label("Summary", systemImage: "figure.walk.circle")
                }
                .tag(Tab.summary)
            
            MainNavigationView(currentTab: .scan)
                .tabItem {
                    Label("Camera", systemImage: "camera.fill")
                }
                .tag(Tab.scan)
            
            MainNavigationView(currentTab: .saved)
                .tabItem {
                    Label("Saved", systemImage: "bookmark.fill")
                }
                .tag(Tab.saved)
            
            MainNavigationView(currentTab: .recipes)
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife.circle.fill")
                }
                .tag(Tab.recipes)
        }
        .accentColor(Color("PriColor"))
        .onAppear {
            UserManager.shared.checkCurrrentState()
            if UserManager.shared.isLoggedIn {
                HelperFunctions.getFoodDataFromDatabase(user: UserManager.shared.userId, collectionName: "foods")
            }
            
        }
    }
}
