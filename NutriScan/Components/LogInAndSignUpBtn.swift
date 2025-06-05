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
    @State var descriptionColor: Color
    @State var bgColor: Color
    @State var borderColor: Color
    
    var body: some View { // this view is for sign in and sign up btns
        HStack(alignment: .center, spacing: 10) {
            if let imgIcon = icon {
                if imgIcon == "Google" {
                    Image(imgIcon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .clipped()
                        .foregroundStyle(Color.primary)

                }else{
                    Image(systemName: imgIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 20, alignment: .leading)
                        .foregroundStyle(Color.primary)
                }
            }
            Text(self.description)
                .foregroundStyle(descriptionColor)
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

