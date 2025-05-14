//
//  FoodCard.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 14/5/25.
//

import SwiftUI

struct FoodCard: View {
    var imageURL: URL
    var foodName: String
    var predictionConfidence: Double
    var body: some View {
        ZStack{
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 175, height: 300)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 175, height: 300)
                        .clipped()
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                @unknown default:
                    EmptyView()
                }
            }
            VStack {
                PredictionProgressView(progress: predictionConfidence)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack{
                    Text(foodName)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                }
                .background(Color.black.opacity(0.3))
                .cornerRadius(10)
                .foregroundColor(Color("DefaultRe"))
            }
            .padding(.bottom, 20)
            .padding(.top, 10)
            .padding(.horizontal, 10)
        }
        .frame(width: 175, height: 300)
        
    }
}

