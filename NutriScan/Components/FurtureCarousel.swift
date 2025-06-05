//
//  FeaturesCarousel.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 4/6/25.
//

import SwiftUI

struct FurtureCarousel: View {

    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "clock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color(UIColor.systemGray))
                Text("Furture Updates")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.systemGray))
                Spacer()
            }
            
            VStack(spacing: 10) {
                Text("Going premium unlocks all of NutriScan's furture features!")
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(UIColor.systemGray5))
                    )
                
                VStack {
                    Image("Steak")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(UIColor.systemGray5))
                )
            }
        }
    }
}

#Preview {
    FurtureCarousel()
}
