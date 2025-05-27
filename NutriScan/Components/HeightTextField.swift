//
//  HeightTextField.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI

struct HeightTextField: View {
    
    @Binding var heightInput: String
    
    var body: some View {
        HStack {
            Image(systemName: "ruler")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            TextField("Height (cm)", text: $heightInput)
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

