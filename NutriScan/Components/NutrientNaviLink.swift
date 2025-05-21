//
//  NutrientNaviLink.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 21/5/25.
//

import SwiftUI

struct NutrientNaviLink: View {
    @State var iconName: String
    @State var iconColor: Color
    @State var name: String

    var body: some View {
        HStack(alignment: .center) {
            HStack() {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(iconColor)
                Text(name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(5)
                
            }
            .foregroundStyle(Color(UIColor.systemGray))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color("InversedPrimary"))
            )
        }
    }
}

