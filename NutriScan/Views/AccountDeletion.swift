//
//  AccountDeletion.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 28/5/25.
//

import SwiftUI

struct AccountDeletion: View {
    
    @State private var isToggled = false
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Text("Account")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundStyle(Color.primary)
                Text("Deletion")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundStyle(Color(UIColor.systemRed))
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 20) {
                
                Text("🚫 This action is irreversible. Once you delete your account, all your data, including saved foods, Nutridex progression, and any other records, will be permanently removed from our system.")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                
                Text("🔐 There's no turing back. You won't be able to retreve any of your data or reactivate your account once it's deleted.")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
            }
            .padding(.all, 50)
            .foregroundStyle(Color.primary)
            
            Spacer()
            
            VStack {
                HStack {
                    Text("By continuing you will remove all data linked to the currently signed in Nutrify account.")
                        .foregroundStyle(Color(UIColor.systemGray))
                        .font(.caption2)
                        .layoutPriority(1)
                    
                    Toggle(isOn: $isToggled) {
                        EmptyView()
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color.green))
                    .padding(.horizontal)
                }
                
                Button {
                    UserManager.shared.deleteUser { isSuccess in
                        UserCache.shared.personalInfo = nil
                        UserCache.shared.accountInfo = nil
                    }
                } label: {
                    Text("DELETE ACCOUNT")
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .fill(isToggled ? Color(UIColor.systemRed) : Color(UIColor.systemGray))
                        )
                }
                .padding(.top, 20)
                .disabled(!isToggled)
                
            }
        }
        .padding()
    }
}

