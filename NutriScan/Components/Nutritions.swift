//
//  Nutritions.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 30/4/25.
//

import SwiftUI

struct Nutritions: View {
    let name: String?
    let value: String?
    let iconName: String?
    let backgroundColor: Color?
    let unit: String
    
    var body: some View {
        HStack {
            // IDEA: Display Nutrition Icon Such as Calorie Protein Fat and Fiber
            Image(systemName: iconName!)
                .font(.title2)
                .foregroundColor(backgroundColor)
                .padding(.all, 5)
            
            // IDEA: Display Nutriont Name and Values
            VStack{
                Text(name!.capitalized)
                    .font(Font.custom("ComicRelief-Bold", size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("\(value ?? "0") \(value == "N/A" ? "" : unit)")
                        .font(Font.custom("ComicRelief-Regular", size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .frame(maxWidth: 150)
            .foregroundColor(.primary)
            
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(Color("ForColor"))
        .cornerRadius(10)
    }
}

