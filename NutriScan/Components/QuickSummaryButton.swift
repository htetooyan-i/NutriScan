//
//  QuickSummaryButton.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 2/6/25.
//

import SwiftUI

struct QuickSummaryButton: View {
    var body: some View {
        HStack {
            Image(systemName: "figure.walk.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundStyle(Color.customBlue)
            Text("Quick Summary")
                .font(.system(size: 12))
                .fontWeight(.bold)
                .foregroundStyle(Color.customBlue)
        }
        .padding(7)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.pri)
        )
    }
}

#Preview {
    QuickSummaryButton()
}
