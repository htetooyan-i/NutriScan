//
//  ModelVersion.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 20/5/25.
//

import SwiftUI

struct ModelVersion: View {
    var body: some View {
        ZStack {
            Color("InversedPrimary")
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "camera.viewfinder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Model Versions")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
                Text("NutriScan's FoodVision model get updated regularly to provide the best results")
                    .fontWeight(.bold)
                    .font(.custom("ComicRelief-Bold", size: 14))
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("FoodVision AI(🍔 👀)")
                        .font(.headline)
                        .foregroundStyle(Color.primary)
                        .fontWeight(.bold)
                    HStack {
                        Text("Version:")
                            .foregroundStyle(Color.primary)
                            .fontWeight(.bold)
                        Spacer()
                        Text("19th May 2025")
                            .fontWeight(.bold)
                    }
                    .padding(.all, 7)
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color(UIColor.systemGray6))
                    )
                })
                .padding(.vertical, 20)
            }
            .foregroundColor(Color(UIColor.systemGray))
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
        }
        .cornerRadius(7)
    }
}
