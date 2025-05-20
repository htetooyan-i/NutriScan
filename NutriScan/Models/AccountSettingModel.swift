//
//  AccountSettingModel.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 20/5/25.
//

import Foundation
import FirebaseAuth

class AccountSettingModel {
    static let shared = AccountSettingModel()
    
    func signUpUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
            } else {
                print("User created: \(authResult?.user.uid ?? "No UID")")
                completion(true)
            }
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
            } else {
                print("User Logged In: \(authResult?.user.email ?? "No UID")")
                completion(true)
            }
        }
    }
}
