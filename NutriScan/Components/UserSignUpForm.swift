//
//  UserSignUpForm.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 20/5/25.
//

import SwiftUI

struct UserSignUpForm: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @Binding var toggler: Bool
    
    // MARK: - validityRules and Results
    let validityRules: [String] = ["email must not be empty", "email must be valid", "password must not be empty", "password must be 6 characters or longer"]
    
    @State var validityChecks:[String:Bool] = [
        "email must not be empty" : false,
        "email must be valid" : false,
        "password must not be empty" : false,
        "password must be 6 characters or longer" : false,
        "password must have an uppercase letter" : false
        
    ]
    // MARK: - main view
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack(alignment: .leading,spacing: 3) { // display the rules and pass or not
                    ForEach(validityRules, id: \.self) { rule in
                        let isPass = validityChecks[rule] ?? false
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .leading)
                                .background(isPass ? Color.green : Color.white)
                                .foregroundStyle(isPass ? Color.white : Color(UIColor.systemGray))
                                .clipShape(Circle())
                            Text(rule)
                                .font(.custom("ComicRelief-Bold", size: 10))
                                .fontWeight(.bold)
                                .strikethrough(isPass, color: Color(UIColor.systemGray3))
                                .foregroundStyle(isPass ? Color(UIColor.systemGray3) : Color(UIColor.systemGray))
                                
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 10)
                
                EmailTextField(email: $email) // email input
                
                PasswordTextField(password: $password) // password input
                
                Button {
                    if !email.isEmpty, !password.isEmpty { // button to login and ensure both email and password are not empty before submit[ But this code need to change and need to check all validation rules]
                        UserManager.shared.signUpUser(email: self.email, password: self.password, context: viewContext) { isSuccess in
                            if isSuccess {
                                print("Successfully created!!")
                                self.email = ""
                                self.password = ""
                                UserDefaults.standard.set(false, forKey: "personalInfoAvailable")
                                toggler = false
                                
                            } else {
                                print("Unsuccess")
                            }
                        }
                    }
                } label: {
                    Text("Sign Up")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .foregroundStyle(Color("InversedPrimary"))
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .fill(Color("CustomBlue"))
                        )
                }
                
            }
            .padding(.vertical, 30)
            .background(Color("InversedPrimary"))
            .cornerRadius(12)
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle("Sign up")
        .navigationBarTitleDisplayMode(.inline)
        
        .onChange(of: email) { oldValue, newValue in
            checkValidity(email: email, password: password)
        }
        .onChange(of: password) { oldValue, newValue in
            checkValidity(email: email, password: password)
        }
    }
    
    func checkValidity(email: String, password: String) { // function to check validityrules
        let results = HelperFunctions.checkEmailAndPasswordValidity(email, password)
        
        self.validityChecks["email must not be empty"] = results["isEmailNotEmpty"]
        self.validityChecks["email must be valid" ] = results["isEmailValid"]
        self.validityChecks["password must not be empty"] = results["isPasswordNotEmpty"]
        self.validityChecks["password must be 6 characters or longer"] = results["isPasswordLongEnough"]
//        self.validityChecks["password must have an uppercase letter"] = results["hasUppercasePassword"]
    }
}

