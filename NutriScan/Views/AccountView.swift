//
//  AccountView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 18/5/25.
//
import SwiftUI

struct AccountView: View {
    @StateObject private var accountModel = UserManager.shared
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // MARK: - Section To Display Account Type
                    
                    AccountType()
                    
                    // MARK: -  Section To Display Account Login And Signup
                    
                    AccountAuthentication(isLoggedIn: $accountModel.isLoggedIn)
                    
                    // MARK: -  Section To Display Available Foods
                    
                    NavigationLink {
                        FoodListView()
                    } label: {
                        FoodAvailability()
                            .background(Color("InversedPrimary"))
                            .cornerRadius(7)
                    }
                    
                    // MARK: - Section To Display Models' Versions
                    
                    ModelVersion()
                    
                    if accountModel.isLoggedIn { // This two sections will be shown only if user has signed in
                        // MARK: - Section To Display Account Sign Out
                        
                        SignOutAndDeleteView(titleIcon: "person.fill", titleName: "Sign Out", description: "Tap the button below to sign out of NutriScan.", btnIcon: "door.left.hand.open")
                        
                        // MARK: - Section To Display Account Delete
                        
                        SignOutAndDeleteView(titleIcon: "person.fill.xmark", titleName: "Delete Account", description: "Tap the buttom below to delete your account from NutriScan (warning: this will delete all data and is irreversible).", btnIcon: "person.crop.circle.badge.xmark")
                    }
                    
                    
                }
                .padding()
            }
            .background(Color(UIColor.systemGray6))
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
        .tint(Color("CustomBlue"))
    }
}

#Preview {
    AccountView()
}
