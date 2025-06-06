//
//  ContentView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 25/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedTab: Tab = .scan
    
    enum Tab {
        case account, summary, scan, saved, noti
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
            
            MainNavigationView(currentTab: .noti)
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tag(Tab.noti)
            
            MainNavigationView(currentTab: .saved)
                .tabItem {
                    Label("Saved", systemImage: "bookmark.fill")
                }
                .tag(Tab.saved)
        }
        .accentColor(Color("PriColor"))
        .onAppear {
            UserManager.shared.checkCurrrentState()
            
            if UserManager.shared.isLoggedIn {
                HelperFunctions.getFoodDataFromDatabase(user: UserManager.shared.userId, collectionName: "foods")
                HelperFunctions.getUserDataFromDatabase()
                HelperFunctions.getUserAccDataFromDatabase()
//                CoreDataHelperFunctions.shared.storeFirebaseDataToCoreData(context: viewContext)
            }
        }
    }
}
