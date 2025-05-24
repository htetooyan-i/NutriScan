//
//  AccountAuthentication.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 19/5/25.
//

import SwiftUI

struct AccountAuthentication: View {
    
    @Binding var isLoggedIn: Bool
    @ObservedObject var accountModel = UserManager.shared
    @State var showSingupSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color("InversedPrimary")
            if isLoggedIn { // if user has logged in this section will show user info
                VStack {
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color(UIColor.systemGray))
                        Text("User Info")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(UIColor.systemGray))
                        Spacer()
                    }
                    UserInfo(fieldName: "Email", fieldValue: $accountModel.email)
                        .padding(.top, 20)
                    
                    UserInfo(fieldName: "User Id", fieldValue: $accountModel.userId)
                        .padding(.top, 20)
                    
                    
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
            }else { // else this section will show option to sign up or login
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit( )
                        .frame(width: 50, height: 50, alignment: .leading)
                        .foregroundColor(Color(UIColor.systemGray2))
                    VStack(alignment: .leading) {
                        Text("Sign into NutriScan")
                            .font(.headline)
                            .foregroundColor(Color("CustomBlue"))
                        Spacer()
                        
                        Text("Create a NutriScan account to backup and save data online.")
                            .font(.caption)
                    }
                    Spacer()
                }
                .padding(.vertical, 20)
                .padding(.leading, 10)
                .onTapGesture {
                    self.showSingupSheet.toggle()
                }
                
            }
            
        }
        .cornerRadius(7)
        .sheet(isPresented: $showSingupSheet) { // when user click the section to sign in/sing up this sheet will be shown
            //Code When sheet has been dismissed
        } content: {
            AccountAuthSheetView(toggler: $showSingupSheet)
        }

    }
}
