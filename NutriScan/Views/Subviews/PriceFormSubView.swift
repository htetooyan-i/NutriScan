//
//  PriceSubView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 3/5/25.
//

import SwiftUI

struct PriceFormSubView: View {
    @Binding var foodPrice: Double?
    @Binding var inputDisable: Bool
    
    @FocusState.Binding var isPriceInputFocused: Bool
    
    var body: some View {
        VStack {
            HStack { // Show total price value
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                Text("Total Price")
                Spacer()
                Text(foodPrice != nil ? "$ \(String(format: "%.1f", foodPrice!))" : "")
            }
            .foregroundColor(Color.gray)
            .fontWeight(.bold)
            .font(.caption)
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            // Call Price view compoent for input text field
            Price(price: $foodPrice, isDisable: $inputDisable, isPriceInputFocused: $isPriceInputFocused)
        }
        .transition(.opacity)
    }
}
