//
//  EmailTextField.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 21/5/25.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var email: String
    var body: some View { // view to show email text field
        HStack(spacing: 20)  {
            Image(systemName: "envelope")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 25)
            TextField( "Email", text: $email )
                .padding()
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(7)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
        }
        .padding(.horizontal, 20)
        .frame(height: 50)
    }
}
