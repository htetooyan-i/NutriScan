//
//  FoodChoices.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 7/5/25.
//

import SwiftUI
import Kingfisher

struct FoodChoices: View {
    @State var foodName: String?
    @State var foodConfidence: Float?
    @State var foodThumb: URL?
    var body: some View {
        HStack {
            // IDEA: Display Food Images if foodThumb is not nil(In this case it can't be nil) else it will display default thumbnail(Food Not Found).

            if let thumbnail = foodThumb
            {
                KFImage(thumbnail)
                    .placeholder {
                        ProgressView()
                    }
                    .cacheOriginalImage()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .clipShape(.circle)
                    .padding(.leading)
            }
            else
            {
                Image("FoodNotFound")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .clipShape(.circle)
                    .padding(.leading)
            }
            
            // Display Food Name and Confidence to be the same as the user's taken food
            VStack{
                Text(foodName ?? "NoFood".capitalized)
                    .font(Font.custom("ComicRelief-Bold", size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    ProgressView(value: foodConfidence ?? 0)
                        .tint(Color("SecColor"))
                    Text(String(format: "%.1f%%", (foodConfidence ?? 0) * 100))
                        .font(Font.custom("ComicRelief-Regular", size: 10))
                }
                .frame(width: 100)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(minWidth: 100)
            .padding(.leading, 20)
            Spacer()
        }
    }
}

#Preview {
    FoodChoices()
}
