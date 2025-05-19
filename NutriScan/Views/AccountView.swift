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
                    AccountType()
                    AccountAuthentication()
                    
                    NavigationLink {
                        FoodListView()
                    } label: {
                        FoodAvailability()
                            .background(Color("InversedPrimary"))
                            .cornerRadius(7)
                    }
                    
                    AccountSignOut()
                    AccountDelete()
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
