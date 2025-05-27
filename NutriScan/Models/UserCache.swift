//
//  UserCache.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 27/5/25.
//

import Foundation

class UserCache: ObservableObject {
    
    static let shared = UserCache()
    
    @Published var personalInfo: PersonalInfo? = nil
    @Published var isLoading: Bool = false

    func setPersonalInfo() {
        self.isLoading = true
        DatabaseModel.getUserInfo(user: UserManager.shared.userId, docName: "personalInfo") { [weak self] result in
            DispatchQueue.main.async {
                self?.personalInfo = result
                self?.isLoading = false
                print("User's personal information has been stored in cache!!")
            }
        }
    }
}

