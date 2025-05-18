//
//  AccountView.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 18/5/25.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                ScrollView(content: {
                    AccountType()
                    
                    ZStack {
                        Color("InversedPrimary")
                        //                        HStack {
                        //                            Image(systemName: "person.crop.circle.fill")
                        //                                .resizable()
                        //                                .scaledToFit( )
                        //                                .frame(width: 50, height: 50, alignment: .leading)
                        //                                .foregroundColor(Color(UIColor.systemGray2))
                        //                            VStack(alignment: .leading) {
                        //                                Text("Sign into NutriScan")
                        //                                    .font(.headline)
                        //                                    .foregroundColor(Color("CustomBlue"))
                        //                                Spacer()
                        //
                        //                                Text("Create a NutriScan account to backup and save data online.")
                        //                                    .font(.caption)
                        //                            }
                        //                            Spacer()
                        //                        }
                        //                        .padding(.vertical, 20)
                        //                        .padding(.leading, 10)
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
                            
                            VStack {
                                Text("Email:")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    Text(verbatim: "i24106.code@gmail.com")
                                        .font(.headline)
                                        .foregroundColor(Color(UIColor.systemGray))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .textContentType(nil)
                                    Image(systemName: "document.on.document")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .padding(6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color("PriColor").opacity(0.5))
                                        )
                                        .foregroundColor(Color("CustomBlue"))
                                }
                                .padding(.top, 20)
                                
                            }
                            .padding(.top, 30)
                            
                            VStack {
                                Text("User Id:")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    Text(verbatim: "i24106.i24106.i24106.i24106")
                                        .font(.headline)
                                        .foregroundColor(Color(UIColor.systemGray))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .textContentType(nil)
                                    Image(systemName: "document.on.document")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .padding(6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color("PriColor").opacity(0.5))
                                        )
                                        .foregroundColor(Color("CustomBlue"))
                                }
                                .padding(.top, 20)
                                
                            }
                            .padding(.top, 30)
                            
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 10)
                    }
                    .cornerRadius(7)
                })
                .padding()
                .navigationTitle("Profile")
                
            }
        }
    }
}

#Preview {
    AccountView()
}
