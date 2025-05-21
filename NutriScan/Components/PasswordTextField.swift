//
//  PasswordTextField.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 21/5/25.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var password: String
    @State var showPassword: Bool = false
    
    var body: some View { // view to show password text field
        HStack(spacing: 20) {
            Image(systemName: "lock")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 25)
            Group {
                if showPassword {
                    TextField("Password", text: $password)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(7)
                } else {
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(7)
                }
            }
            Button(action: {
                showPassword.toggle()
            }) {
                Image(systemName: showPassword ? "eye" : "eye.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 25)
                    .foregroundStyle(Color.primary)
            }
            
        }
        .padding(.horizontal, 20)
        .frame(height: 50)
    }
}
