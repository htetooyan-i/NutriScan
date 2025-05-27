//
//  SuccessBanner.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import SwiftUI

struct SuccessBanner: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.white)
                Text("Saved successfully!")
                    .foregroundColor(.white)
                    .bold()
            }
            .padding()
            .background(Color.green)
            .cornerRadius(10)
            .padding(.top, 50)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .transition(.move(edge: .top).combined(with: .opacity))
        .zIndex(1)
    }
}
