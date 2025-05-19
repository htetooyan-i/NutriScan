//
//  FoodAvailability.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 19/5/25.
//

import SwiftUI

struct FoodAvailability: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "carrot.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color(UIColor.systemGray))
                Text("Available Foods")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.systemGray))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color("CustomBlue"))
                
            }
            
            
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
    }
}

#Preview {
    FoodAvailability()
}
