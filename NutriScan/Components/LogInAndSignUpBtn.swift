//
//  LogInAndSignUpBtn.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 20/5/25.
//

import SwiftUI

struct LogInAndSignUpBtn: View {
    @State var icon: String?
    @State var description: String
    @State var bgColor: Color
    @State var borderColor: Color
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            if let imgIcon = icon {
                Image(systemName: imgIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 25, alignment: .leading)
                    .foregroundStyle(Color.primary)
            }
            Text(self.description)
                .foregroundStyle(Color.primary)
                .fontWeight(.bold)
        }
        .frame(width: 300, height: 50, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(bgColor)
                .stroke(borderColor, lineWidth: 2)
        )
    }
}

