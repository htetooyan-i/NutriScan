//
//  PriceSubView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 3/5/25.
//

import SwiftUI

struct PriceSubView: View {
    @Binding var foodPrice: Double?
    let inputDisable: Bool
    var body: some View {
        VStack {
            HStack { // Show total price value
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                Text("Total Price")
                Spacer()
                if !inputDisable {
                    Text(foodPrice != nil ? "$ \(String(format: "%.1f", foodPrice!))" : "")
                }
            }
            .foregroundColor(Color.gray)
            .fontWeight(.bold)
            .font(.caption)
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            // Call Price view compoent for input text field
            Price(price: $foodPrice, isDisable: false)
        }
        .transition(.opacity)
    }
}
