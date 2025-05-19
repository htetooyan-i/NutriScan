//
//  AccountAuthentication.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 19/5/25.
//

import SwiftUI

struct AccountAuthentication: View {
    @State var isLoggedIn: Bool = true
    @State var email: String = "irandom12394@gmail.com"
    @State var userId: String = "i24106.i24106.i24106.i24106"
    @State var copiedField: String? = nil
    var body: some View {
        ZStack {
            Color("InversedPrimary")
            if isLoggedIn {
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
                    userInfoView(for: "Email", with: email)
                        .padding(.top, 30)
                    
                    userInfoView(for: "User Id", with: userId)
                        .padding(.top, 30)
                    
                    
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
            }else {
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
                
            }
            
        }
        .cornerRadius(7)
    }
    
    func userInfoView(for fieldName: String, with fieldValue: String) -> some View {
        VStack {
            Text("\(fieldName):")
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(verbatim: fieldValue)
                    .font(.headline)
                    .foregroundColor(Color(UIColor.systemGray))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textContentType(nil)
                Button {
                    UIPasteboard.general.string = fieldValue
                    copiedField = fieldName
                    
                    // Hide message after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        copiedField = nil
                    }
                } label: {
                    Image(systemName: "document.on.document")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(10)
                    if copiedField == fieldName {
                        Text("Copied!")
                            .transition(.opacity)
                            .padding(.leading, 0)
                            .padding(.trailing, 10)
                            .padding(.vertical, 10)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("PriColor").opacity(0.5))
                )
                .foregroundColor(Color("CustomBlue"))
            }
            .padding(.top, 20)
            .animation(.easeInOut, value: copiedField)
            
        }
    }
}
