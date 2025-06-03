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
    @Binding var isDisable: Bool
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
            if let price = price, isDisable {
                Text(String(format: "$ %.2f", price))
                    .fontWeight(.bold)
                    .frame(height: 50)
                    .padding(.horizontal)
                Spacer()
            } else {
                TextField("", text: $localPrice)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                    .fontWeight(.bold)
                    .keyboardType(.decimalPad)
            }
            
            // IDEA: Button to save food price.( I don't want to save the price every time input field changes )
            if isDisable {
                Button {
                    isDisable = false
                } label: {
                    Text("Edit")
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .frame(height:50)
                        .padding(.horizontal)
                }
                .background(Color.customOrange)
                .cornerRadius(10)
            } else {
                Button {
                    price = Double(localPrice) ?? 0.0
                    isDisable = true
                } label: {
                    Text("Save")
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .frame(height:50)
                        .padding(.horizontal)
                }
                .background(Color("CustomBlue"))
                .cornerRadius(10)
            }
            

        }
        .padding()
        .onAppear {
            if isDisable {
                guard let price = price, price > 0 else {
                    isDisable = false
                    return
                }
            }
            if let price = price, price > 0 , !isDisable {
                localPrice = String(format: "%.2f", price)
            }
        }
        
        .onChange(of: isDisable) { oldValue, newValue in
            if let price = price, price > 0 , !newValue {
                localPrice = String(format: "%.2f", price)
            }
        }
    }
}

