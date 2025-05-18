//
//  AccountType.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 18/5/25.
//

import SwiftUI

struct AccountType: View {
    var body: some View {
        ZStack {
            Color("PriColor")
            HStack {
                Text("Premium")
                    .font(.system(size: 25, weight: .bold))
                    .padding(.vertical, 20)
                    .padding(.leading, 10)
                    .italic()
                Image(systemName: "crown.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                Spacer()
            }
        }
        .cornerRadius(7)
    }
}
