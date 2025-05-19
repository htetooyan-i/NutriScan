//
//  AccountDelete.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 19/5/25.
//

import SwiftUI

struct AccountDelete: View {
    var body: some View {
        ZStack {
            Color("InversedPrimary")
            VStack(alignment: .leading,spacing: 16, content: {
                HStack {
                    Image(systemName: "person.fill.xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Delete Account")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
                Text("Tap the buttom below to delete your account from NutriScan(warning: this will delete all data and is irreversible.")
                    .fontWeight(.bold)
                    .font(.custom("ComicRelief-Bold", size: 14))
                
                Button {
                    print("Account Deleted")
                } label: {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.xmark")
                        Text("Delete Account")
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

#Preview {
    AccountDelete()
}
