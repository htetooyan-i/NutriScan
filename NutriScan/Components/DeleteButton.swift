//
//  DeleteButton.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 2/6/25.
//

import SwiftUI

struct DeleteButton: View {
    var body: some View {
        HStack {
            Image(systemName: "trash")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundStyle(Color.red)
        }
        .padding(7)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.red.opacity(0.5))
        )
    }
}

#Preview {
    DeleteButton()
}
