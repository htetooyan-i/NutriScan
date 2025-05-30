//
//  Prediction.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 29/4/25.
//

import SwiftUI
import AVFoundation


struct Prediction: View {
    @Environment(\.dismiss) var dismiss
    @State var foodName: String?
    @State var confidence: Float?
    @State var thumb: UIImage?
    @Binding var saved: Bool
    
    
    var body: some View {
        HStack {
            // MARK: - PREDICTION THUMBNAIL
            if let thumb = thumb{
                Image(uiImage: thumb)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(.circle)
            } else {
                Image("FoodNotFound")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(.circle)
            }
            // MARK: - FOOD LABEL
            VStack{
                Text(foodName ?? "NoFood".capitalized)
                    .font(Font.custom("ComicRelief-Bold", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    ProgressView(value: confidence ?? 0)
                        .tint(Color("SecColor"))
                    Text(String(format: "%.0f%%", (confidence ?? 0) * 100))
                        .font(Font.custom("ComicRelief-Regular", size: 15))
                }
                
            }
            .frame(maxWidth: 150)
            .padding(.leading, 20)
            Spacer()
            
            // MARK: - SAVE BUTTON TO SAVE FOOD
            Button {
                if UserManager.shared.isLoggedIn {
                    print("Saved Toggled")
                    saved.toggle()
                }
            } label: {
                if UserManager.shared.isLoggedIn {
                    Image(systemName: saved ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .frame(width: 20, height: 25)
                        .foregroundColor(.blue)
                }else {
                    Image(systemName: "bookmark.slash.fill")
                        .resizable()
                        .frame(width: 20, height: 25)
                        .foregroundColor(.red)
                }
            }
            .disabled(UserManager.shared.isLoggedIn ? false : true)
            .onChange(of: saved) { oldValue, newValue in
                if newValue == true {
                    HelperFunctions.makeVibration(feedbackStyle: .heavy)
                }
            }
            .onAppear {
                print("Current State: \(UserManager.shared.isLoggedIn)")
            }
        }
    }
    
}
