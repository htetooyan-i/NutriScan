//
//  UserManager.swift
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
    
    // MARK: -  Sign Up User
    func signUpUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
            } else {
                print("User created: \(authResult?.user.uid ?? "No UID")")
                self.isLoggedIn = true
                self.getCurrentUserData()
                
                let userInfo = [
                    "userId": UserManager.shared.userId,
                    "email": UserManager.shared.email,
                ]

                DatabaseModel.createUserInfo(user: UserManager.shared.userId, collectionName: "userInfo", docName: "accountInfo", data: userInfo) { isSuccess in
                    print("Stored in database?: \(isSuccess)")
                    completion(isSuccess)
                }
            }
        }
    }
    
    // MARK: - Sign In User
    func signInUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
            } else {
                print("User Logged In: \(authResult?.user.email ?? "No UID")")
                self.isLoggedIn = true
                self.getCurrentUserData()
                HelperFunctions.getFoodDataFromDatabase(user: self.userId, collectionName: "foods")
                completion(true)
            }
        }
    }
    
    // MARK: - Sign Out User
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
    
    // MARK: - Check Logged In Or Not
    func checkCurrrentState() {
        if Auth.auth().currentUser != nil {
            self.isLoggedIn = true
            self.getCurrentUserData()
        } else {
            print("No user is signed in.")
            self.isLoggedIn = false
        }

    }
    
    // MARK: - Delete User Account
    func deleteUser(completion: @escaping (Bool) -> Void) {
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    print("Error deleting user: \(error.localizedDescription)")
                    completion(false)
                } else {

                    self.isLoggedIn = false

                    DatabaseModel.deleteUser(user: self.userId) { isSuccess in
                        print("deleted in database?: \(isSuccess)")
                        completion(isSuccess)
                    }
                }
            }
        } else {
            print("No user is currently signed in.")
            completion(false)
        }

    }
    // MARK: - Set the User Info
    private func getCurrentUserData() {
        if let user = Auth.auth().currentUser {
            self.email = user.email ?? ""
            self.userId = user.uid
        }
    }
}
