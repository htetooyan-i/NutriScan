//
//  AccountDelete.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 19/5/25.
//

import SwiftUI

struct SignOutAndDeleteView: View {
    @State var titleIcon: String
    @State var titleName: String
    @State var description: String
    @State var btnIcon: String
    var body: some View {
        ZStack {
            Color("InversedPrimary")
            VStack(alignment: .leading,spacing: 16, content: {
                HStack {
                    Image(systemName: self.titleIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text(self.titleName)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
                Text(self.description)
                    .fontWeight(.bold)
                    .font(.custom("ComicRelief-Bold", size: 14))
                
                Button {
                    if self.titleName == "Sign Out" {
                        AccountSettingModel.shared.signOutUser { isSuccess in
                            print(isSuccess)
                        }
                    }else {
                        AccountSettingModel.shared.deleteUser { isSuccess in
                            print(isSuccess)
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: self.btnIcon)
                        Text(self.titleName)
                    }
                    .padding(.all, 7)
                    .foregroundColor(Color("InversedDanger"))
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color("Danger").opacity(0.5))
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            })
            .foregroundStyle(Color(UIColor.systemGray))
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
        }
        .cornerRadius(7)
    }
}

