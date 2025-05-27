//
//  AccountView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 18/5/25.
//
import SwiftUI

struct AccountView: View {
    @StateObject private var accountModel = UserManager.shared
    @State var showSuccessBanner: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 16) {
                        // MARK: - Section To Display Account Type
                        AccountType()

                        // MARK: - Account Login/Signup
                        AccountAuthentication(isLoggedIn: $accountModel.isLoggedIn)

                        // MARK: - Navigation to Food List
                        NavigationLink {
                            FoodListView()
                        } label: {
                            FoodAvailability()
                                .background(Color("InversedPrimary"))
                                .cornerRadius(7)
                        }

                        // MARK: - Personal Info
                        UserPersonalInfo(showSuccessBanner: $showSuccessBanner)

                        // MARK: - Model Versions
                        ModelVersion()

                        if accountModel.isLoggedIn {
                            SignOutAndDeleteView(
                                titleIcon: "person.fill",
                                titleName: "Sign Out",
                                description: "Tap the button below to sign out of NutriScan.",
                                btnIcon: "door.left.hand.open"
                            )
                            
                            SignOutAndDeleteView(
                                titleIcon: "person.fill.xmark",
                                titleName: "Delete Account",
                                description: "Tap the buttom below to delete your account from NutriScan (warning: this will delete all data and is irreversible).",
                                btnIcon: "person.crop.circle.badge.xmark"
                            )
                        }
                    }
                    .padding()
                    .navigationTitle("Profile")
                    .navigationBarTitleDisplayMode(.large)
                }
                .background(Color(UIColor.systemGray6))
            }

            if showSuccessBanner {
                SuccessBanner()
            }
        }
        .animation(.spring(), value: showSuccessBanner)
        .tint(Color("CustomBlue"))
    }
}
