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
                })
                .padding()
                .navigationTitle("Profile")
                
            }
        }
    }
}

#Preview {
    AccountView()
}
