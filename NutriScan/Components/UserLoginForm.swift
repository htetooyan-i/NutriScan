//
//  UserLoginForm.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 20/5/25.
//

import SwiftUI

struct UserLoginForm: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State var logInFail: Bool = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack(spacing: 20)  {
                    Image(systemName: "envelope")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 25)
                    TextField( "Email", text: $email )
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(7)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                }
                .padding(.horizontal, 20)
                .frame(height: 50)
                
                HStack(spacing: 20) {
                    Image(systemName: "lock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 25)
                    Group {
                        if showPassword {
                            TextField("Password", text: $password)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(7)
                        } else {
                            SecureField("Password", text: $password)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(7)
                        }
                    }
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 25)
                            .foregroundStyle(Color.primary)
                    }
                    
                }
                .padding(.horizontal, 20)
                .frame(height: 50)
                
                if logInFail {
                    Text("Email or password is incorrect!")
                        .font(.caption)
                        .foregroundStyle(Color.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button {
                    if !email.isEmpty, !password.isEmpty {
                        AccountSettingModel.shared.signInUser(email: self.email, password: self.password) { isSuccess in
                            if isSuccess {
                                print("Success")
                                self.logInFail = false
                                self.email = ""
                                self.password = ""
                            } else {
                                self.logInFail = true
                            }
                        }
                    }
                } label: {
                    Text("Login")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .foregroundStyle(Color("InversedPrimary"))
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color("CustomBlue"))
                        )
                }
                
            }
            .padding(.top, 60)
            .padding(.bottom, 30)
            .background(Color.white)
            .cornerRadius(12)
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserLoginForm()
}
