//
//  AccountSettingModel.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 20/5/25.
//

import Foundation
import FirebaseAuth

class UserManager: ObservableObject {
    static let shared = UserManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""
    @Published var userId: String = ""
    
    func signUpUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
            } else {
                print("User created: \(authResult?.user.uid ?? "No UID")")
                self.isLoggedIn = true
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
                self.isLoggedIn = true
                self.getCurrentUserData()
                completion(true)
            }
        }
    }
    
    func signOutUser(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            print("Signed out")
            self.isLoggedIn = false
            completion(true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            completion(false)
        }
    }
    
    func checkCurrrentState() {
        if let user = Auth.auth().currentUser {
            self.isLoggedIn = true
            self.getCurrentUserData()
        } else {
            print("No user is signed in.")
            self.isLoggedIn = false
        }

    }
    
    func deleteUser(completion: @escaping (Bool) -> Void) {
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    print("Error deleting user: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("User account deleted successfully.")
                    self.isLoggedIn = false
                    completion(true)
                }
            }
        } else {
            print("No user is currently signed in.")
            completion(false)
        }

    }
    
    private func getCurrentUserData() {
        if let user = Auth.auth().currentUser {
            self.email = user.email ?? ""
            self.userId = user.uid
        }
    }
}
