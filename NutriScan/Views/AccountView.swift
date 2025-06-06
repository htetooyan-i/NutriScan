//
//  AccountView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 18/5/25.
//
import SwiftUI

struct AccountView: View {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    ) var foods: FetchedResults<FoodEntity>
    
    @StateObject private var accountModel = UserManager.shared
    @StateObject private var userCacheModel = UserCache.shared
    
    @State var showSuccessBanner: Bool = false
    @State var userPersonalInfo: PersonalInfo? = nil
    @State var userAccountInfo: AccountInfo? = nil
    
    @AppStorage("accountType") var accountType: String?
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 16) {
                        // MARK: - Section To Display Account Type
                        if accountType == "free" {
                            NavigationLink(destination: PremiumSubscription()) {
                                AccountType()
                                    .id(UUID())
                            }
                        } else {
                            // Optional: fallback for other account types
                            AccountType()
                                .id(UUID())
                        }
                        
                        
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
                        
                        if accountModel.isLoggedIn {
                            // MARK: - Personal Info
                            UserPersonalInfo(showSuccessBanner: $showSuccessBanner, personalInfo: $userPersonalInfo)
                        }
                        
                        // MARK: - Model Versions
                        ModelVersion()
                        
                        // MARK: - Photo Saving
                        
                        PhotoSaving()
                        
                        // MARK: - Account Sign Out And Deletion
                        
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
        .onAppear {
            if !userCacheModel.isLoading {
                self.userPersonalInfo = userCacheModel.personalInfo
                self.userAccountInfo = userCacheModel.accountInfo
                
            }
        }
        .onChange(of: userCacheModel.personalInfo) { oldValue, newValue in
            self.userPersonalInfo = userCacheModel.personalInfo
        }
        
        .onChange(of: userCacheModel.accountInfo) { oldValue, newValue in
            self.userAccountInfo = userCacheModel.accountInfo
        }
    }
}
