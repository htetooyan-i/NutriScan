//
//  Prediction.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 29/4/25.
//

import SwiftUI
import AVFoundation


struct Prediction: View {
    @State var foodName: String?
    @State var confidence: Float?
    @State var thumb: UIImage?
    @Binding var saved: Bool
//    
//    var audioPlayer: AVAudioPlayer?
    
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
                saved.toggle()
            } label: {
                Image(systemName: saved ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .frame(width: 20, height: 25)
                    .foregroundColor(.blue)
            }
            .onChange(of: saved) { oldValue, newValue in
                if newValue == true {
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.prepare()
                    generator.impactOccurred()
                    SoundManager.shared.playClickSound()
                }
            }
            
        }
    }
    
}
