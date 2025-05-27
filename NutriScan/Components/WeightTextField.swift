//
//  WeightTextField.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI

struct WeightTextField: View {
    
    @Binding var weightInput: String
    var body: some View {
        HStack {
            Image(systemName: "scalemass")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            TextField("Weight (kg)", text: $weightInput)
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
