//
//  PhotoSaving.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 4/6/25.
//

import SwiftUI

struct PhotoSaving: View {
    
    @StateObject var userCache = UserCache.shared

    @AppStorage("photoSaving") var photoSaving: Bool?
    @State var isSavingPhoto: Bool = false
    
    var body: some View {
        VStack(spacing: 20){
            HStack {
                Image(systemName: "person.2.crop.square.stack")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color(UIColor.systemGray))
                Text("Photo Saving")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.systemGray))
                Spacer()
            }
            
            Text("Save photos taken with NutriScan to the Photo app.")
                .fontWeight(.bold)
                .font(.custom("ComicRelief-Bold", size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color(UIColor.systemGray))
            Toggle(isOn: $isSavingPhoto) {
                Text(isSavingPhoto ? "Saving": "Not Saving")
                    .foregroundStyle(Color.primary)
                    .fontWeight(.bold)
            }
            .toggleStyle(SwitchToggleStyle(tint: Color.green))

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(Color("InversedPrimary"))
        )
        .onAppear {
            if !userCache.isLoading {
                self.isSavingPhoto = photoSaving ?? false
            }
        }
        
        .onChange(of: userCache.isLoading) { oldValue, newValue in
            if !newValue {
                self.isSavingPhoto = photoSaving ?? false
            }
        }
        
        .onChange(of: isSavingPhoto) { oldValue, newValue in
            UserDefaults.standard.set(newValue, forKey: "photoSaving")
        }
    }
}

