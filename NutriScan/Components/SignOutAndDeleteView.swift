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
    @State var showReminder: Bool = false
    var body: some View { // this view will show the sign out and delete account sections
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
                    if self.titleName == "Sign Out" { // if this view has been called for sign out section call the signOut func
                        UserManager.shared.signOutUser { isSuccess in
                            UserCache.shared.personalInfo = nil
                            UserCache.shared.accountInfo = nil
                            
                        }
                    }else {// else call the delete account func
                        self.showReminder = true
                    }
                    FoodCache.shared.foodDataCacheByDate = [:]
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
                
                .sheet(isPresented: $showReminder) {
                    AccountDeletion()
                }
                
                
            })
            .foregroundStyle(Color(UIColor.systemGray))
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
        }
        .cornerRadius(7)
    }
}

