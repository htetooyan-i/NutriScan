//
//  MainNavigationView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 14/5/25.
//

import SwiftUI

struct MainNavigationView: View {
    @State var currentTab: Tab
    
    enum Tab {
        case account, summary, scan, saved, recipes
    }
    var body: some View {
        switch currentTab {
        case .account:
            Text("Account")
        case .summary:
            Text("Summary")
        case .scan:
            ZStack {
                CameraView()
                CameraOverlayView()
            }
        case .saved:
            SavedView()
        case .recipes:
            Text("Recipes")
        }
    }
}
