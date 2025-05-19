//
//  AccountView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 18/5/25.
//
import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // MARK: - Section To Display Account Type
                    
                    AccountType()
                    
                    // MARK: -  Section To Display Account Login And Signup
                    
                    AccountAuthentication()
                    
                    // MARK: -  Section To Display Available Foods
                    
                    NavigationLink {
                        FoodListView()
                    } label: {
                        FoodAvailability()
                            .background(Color("InversedPrimary"))
                            .cornerRadius(7)
                    }
                    
                    // MARK: - Section To Display Models' Versions
                    
                    ZStack {
                        Color("InversedPrimary")
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "camera.viewfinder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("Model Versions")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            Text("NutriScan's FoodVision model get updated regularly to provide the best results")
                                .fontWeight(.bold)
                                .font(.custom("ComicRelief-Bold", size: 14))
                            
                            VStack(alignment: .leading, spacing: 10, content: {
                                Text("FoodVision AI(🍔 👀)")
                                    .font(.headline)
                                    .foregroundStyle(Color.primary)
                                    .fontWeight(.bold)
                                HStack {
                                    Text("Version:")
                                        .foregroundStyle(Color.primary)
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text("19th May 2025")
                                        .fontWeight(.bold)
                                }
                                .padding(.all, 7)
                                .background(
                                    RoundedRectangle(cornerRadius: 7)
                                        .fill(Color(UIColor.systemGray6))
                                )
                            })
                            .padding(.vertical, 20)
                        }
                        .foregroundColor(Color(UIColor.systemGray))
                        .padding(.vertical, 20)
                        .padding(.horizontal, 10)
                    }
                    .cornerRadius(7)
                    
                    // MARK: - Section To Display Account Sign Out
                    
                    SignOutAndDeleteView(titleIcon: "person.fill", titleName: "Sign Out", description: "Tap the button below to sign out of NutriScan.", btnIcon: "door.left.hand.open")
                    
                    // MARK: - Section To Display Account Delete
                    
                    SignOutAndDeleteView(titleIcon: "person.fill.xmark", titleName: "Delete Account", description: "Tap the buttom below to delete your account from NutriScan (warning: this will delete all data and is irreversible).", btnIcon: "person.crop.circle.badge.xmark")
                    
                    
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
