//
//  NoFoodFound.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 16/5/25.
//

import SwiftUI

struct FoodNotFound: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            Text("You have nothing to find here, go take some photos of food and comback!")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .font(.custom("ComicRelief-Regular", size: 18))
            
            Image(systemName: "magnifyingglass")
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(Color("InversedPrimary"))
        .cornerRadius(10)
    }
}

