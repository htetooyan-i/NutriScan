//
//  AccountType.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 18/5/25.
//

import SwiftUI

struct AccountType: View {
    @Binding var accountInfo: AccountInfo?
    @StateObject private var accountModel = UserManager.shared
    
    var body: some View { // show the account type of current user
        
        ZStack {
            Color(accountInfo?.accountType == "premium" && accountModel.isLoggedIn ? "PriColor" : "SecColor")
            HStack {
                Text(accountInfo?.accountType == "premium" && accountModel.isLoggedIn ? "Premium" : "Go Premium")
                    .font(.system(size: 25, weight: .bold))
                    .padding(.vertical, 20)
                    .padding(.leading, 10)
                    .italic()
                Image(systemName: "crown.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                Spacer()
            }
        }
        .cornerRadius(7)
    }
}
