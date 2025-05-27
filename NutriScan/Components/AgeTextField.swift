//
//  AgeTextField.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI

struct AgeTextField: View {
    @Binding var ageInput: String
    var body: some View {
        HStack {
            Image(systemName: "person.2.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            TextField("age", text: $ageInput)
                .keyboardType(.decimalPad)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color(UIColor.systemGray6))
                )
                .foregroundStyle(Color.primary)
                
        }
    }
}

