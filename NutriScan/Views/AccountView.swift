//
//  AccountView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 18/5/25.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                ScrollView(content: {
                    AccountType()
                    AccountAuthentication()
                    NavigationLink {
                        FoodListView()
                    } label: {
                        FoodAvailability()
                            .background(Color("InversedPrimary"))
                            .cornerRadius(7)
                    }
                })
                .padding()
                .navigationTitle("Profile")
            }
        }
        .tint(Color("CustomBlue"))
    }
}

#Preview {
    AccountView()
}
