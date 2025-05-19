//
//  AccountSignOut.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 19/5/25.
//

import SwiftUI

struct AccountSignOut: View {
    var body: some View {
        ZStack {
            Color("InversedPrimary")
            VStack(alignment: .leading,spacing: 16, content: {
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Sign Out")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
                Text("Tap the button below to sign out of NutriScan.")
                    .fontWeight(.bold)
                    .font(.custom("ComicRelief-Bold", size: 14))
                
                Button {
                    print("Account Signed Out")
                } label: {
                    HStack {
                        Image(systemName: "door.left.hand.open")
                        Text("Sign Out")
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
    AccountSignOut()
}
