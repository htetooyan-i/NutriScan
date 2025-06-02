//
//  QuickSummarySelectedFoods.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 3/6/25.
//

import SwiftUI
import Kingfisher
struct QuickSummarySelectedFoods: View {
    
    @Binding var selectedFoods: [SelectedFoods]
    @Binding var showSelectedFoods: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("\(selectedFoods.count) Food Selected")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .rotationEffect(Angle(degrees: showSelectedFoods ? 90 : 0))
            }
            if showSelectedFoods {
                Divider()
                
                VStack {
                    ForEach(selectedFoods) { food in
                        HStack {
                            // IDEA: Display Nutrition Icon Such as Calorie Protein Fat and Fiber
                            KFImage(food.thumbnail)
                                .placeholder {
                                    ProgressView()
                                }
                                .resizable()
                                .cacheOriginalImage()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Text(food.name)
                                .font(Font.custom("ComicRelief-Bold", size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                    }
                    
                }
                
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(Color("InversedPrimary"))
        )
        .onTapGesture {
            withAnimation {
                showSelectedFoods.toggle()
            }
        }
    }
}
