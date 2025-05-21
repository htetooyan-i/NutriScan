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
    @Binding var toggler: Bool
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                EmailTextField(email: $email) // email input
                
                PasswordTextField(password: $password) // password input
                
                if logInFail { // if login has failed this error will be shown
                    Text("Email or password is incorrect!")
                        .font(.caption)
                        .foregroundStyle(Color.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                }
                
                Button { // button to login and ensure both email and password are not empty before submit
                    if !email.isEmpty, !password.isEmpty {
                        UserManager.shared.signInUser(email: self.email, password: self.password) { isSuccess in
                            if isSuccess {
                                print("Success")
                                self.logInFail = false
                                self.email = ""
                                self.password = ""
                                toggler = false
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
            .background(Color("InversedPrimary"))
            .cornerRadius(12)
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
    }
}
