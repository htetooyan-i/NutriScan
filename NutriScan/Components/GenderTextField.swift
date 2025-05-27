//
//  GenderTextField.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI

struct GenderTextField: View {
    @Binding var gender: String
    var body: some View {
        HStack {
            Image(systemName: "figure.stand.dress.line.vertical.figure")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            TextField("Gender (e.g. Male/Female)", text: $gender)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color(UIColor.systemGray6))
                )
                .textInputAutocapitalization(.never)
                .foregroundStyle(Color.primary)
        }
    }
}

