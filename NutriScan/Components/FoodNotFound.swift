//
//  NoFoodFound.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 16/5/25.
//

import SwiftUI

struct FoodNotFound: View {
    @State var message: String
    @State var icon: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            Text(message)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .font(.custom("ComicRelief-Regular", size: 18))
            
            Image(systemName: icon)
                .foregroundStyle(Color("CustomBlue"))
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(Color("InversedPrimary"))
        .cornerRadius(10)
    }
}

