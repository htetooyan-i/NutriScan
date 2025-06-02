//
//  SavedViewActionBar.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 2/6/25.
//

import SwiftUI

struct SavedViewActionBar: View {
    
    @Binding var deleteFoods: Bool
    @Binding var showSummary: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    showSummary = true
                    print("Quick Summary")
                } label: {
                    QuickSummaryButton()
                }

                Spacer()
                Button {
                    deleteFoods = true
                    print("Delete")
                } label: {
                    DeleteButton()
                }

            }
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color.inversedPrimary)
                    .shadow(radius: 5)
            )
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .padding(.horizontal)
        .padding(.bottom, 7)
    }
}
