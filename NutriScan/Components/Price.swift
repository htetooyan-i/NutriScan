//
//  Price.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 2/5/25.
//

import SwiftUI

struct Price: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var price: Double?
    @State var localPrice: String = ""
    @State var isDisable: Bool = false
    var body: some View {
        HStack {
            // Display Price Icon
            Image(systemName: "tag.circle")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.trailing, 5)
            // Display Price Text
            Text("Price")
            // Input Text Field to enter food price
            TextField("", text: $localPrice)
                .frame(height: 50)
                .padding(.horizontal)
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .fontWeight(.bold)
                .keyboardType(.decimalPad)
                .disabled(isDisable)
            // IDEA: Button to save food price.( I don't want to save the price every time input field changes )
            Button {
                price = Double(localPrice) ?? 0.0
            } label: {
                Text("Save")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .frame(height:50)
                    .padding(.horizontal)
            }
            .background(Color("CustomBlue"))
            .cornerRadius(10)
            

        }
        .padding()
    }
}

