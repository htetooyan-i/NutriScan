//
//  NoFoodFound.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 16/5/25.
//

import SwiftUI

struct FoodNotFound: View {
    @State var messages: [String] = ["You have nothing to find here, go take some photos of food and comback!", "Saved images will appear here, get snapping. \n Go Login first!"]
    @State var icons: [String] = ["magnifyingglass", "figure.climbing"]
    
    @State var isLoggedIn: Bool = UserManager.shared.isLoggedIn
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            Text(isLoggedIn ? messages[0] : messages[1])
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .font(.custom("ComicRelief-Regular", size: 18))
            
            Image(systemName: isLoggedIn ? icons[0] : icons[1])
                .foregroundStyle(Color("CustomBlue"))
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(Color("InversedPrimary"))
        .cornerRadius(10)
    }
}

