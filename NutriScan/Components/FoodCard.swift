//
//  FoodCard.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 14/5/25.
//

import SwiftUI
import Kingfisher

struct FoodCard: View {
    
    var imageURL: URL
    var foodName: String
    var predictionConfidence: Double
    
    @State private var loadFailed = false
    
    var body: some View {

        ZStack{
            
            if loadFailed {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
            } else {
                KFImage(imageURL)
                    .placeholder {
                        ProgressView()
                            .frame(width: 175, height: 300)
                    }
                    .onFailure { _ in
                        loadFailed = true
                    }
                    .resizable()
                    .cacheOriginalImage()
                    .scaledToFill()
                    .frame(width: 175, height: 300)
                    .clipped()
                    .cornerRadius(10)
                    
            }
            
            VStack {
                PredictionProgressView(progress: predictionConfidence) // show the confidence of the prediction by progress view
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack{ // show the food name with a box
                    Text(foodName)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                }
                .background(Color(UIColor.systemGray6).opacity(0.7))
                .cornerRadius(10)
                .foregroundColor(Color.primary)
            }
            .padding(.bottom, 20)
            .padding(.top, 10)
            .padding(.horizontal, 10)
        }
        .frame(width: 175, height: 300)
        .background(Color("InversedPrimary"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("InversedPrimary"), lineWidth: 3)
        )
        
        
    }
}

