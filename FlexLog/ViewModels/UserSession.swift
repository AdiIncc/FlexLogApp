//
//  UserSession.swift
//  FlexLog
//
//  Created by Adrian Inculet on 24.02.2026.
//

import Foundation

@Observable
class UserSession {
    var currentUser: User? {
        didSet {
            saveCurrentUser()
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "user_session_data"), let decodedUser = try? JSONDecoder().decode(User.self, from: data) {
            self.currentUser = decodedUser
        }
    }
    
    private func saveCurrentUser() {
        if let currentUser = currentUser {
            if let encoded = try? JSONEncoder().encode(currentUser) {
                UserDefaults.standard.set(encoded, forKey: "user_session_data")
            }
        } else {
            UserDefaults.standard.removeObject(forKey: "user_session_data")
        }
    }
    
}
