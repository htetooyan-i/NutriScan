//
//  WeightSubView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 3/5/25.
//

import SwiftUI

struct WeightFormSubView: View {
    @Binding var foodWeight: String
    @Binding var foodQuantity: Int
    var body: some View {
        HStack { // Show total food weight
            Image(systemName: "scalemass")
                .resizable()
                .frame(width: 25, height: 25)
            Text("Total Weight")
            Spacer()
            Text("Per: \(String(format: "%.1f", (Double(foodWeight) ?? 0) * Double(foodQuantity))) g")
        }
        .foregroundColor(Color.gray)
        .fontWeight(.bold)
        .font(.caption)
        .padding(.horizontal)
        .padding(.top)
        
        Divider()
        
        VStack{
            // Call Weight view component to input food weight and food quantity values
            Weight(weight: $foodWeight, serve: $foodQuantity, isDisable: false)
        }
        .background(Color("DefaultRe"))
        .cornerRadius(20)
        .transition(.opacity)
    }
}
