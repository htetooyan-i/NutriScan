//
//  PersonalInfoValue.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 28/5/25.
//

import SwiftUI

struct PersonalInfoValue: View {
    @State var iconName: String
    @State var infoName: String
    @State var infoValue: String
    @State var unit: String?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text(infoName)
                    .fontWeight(.bold)
            }
            .foregroundStyle(Color.primary)
            
            Text("\(infoValue) \(unit ?? "")")
                .fontWeight(.bold)
                .foregroundStyle(Color(UIColor.systemGray))
                
        }
    }
}

