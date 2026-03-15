//
//  WelcomeViewModel.swift
//  FlexLog
//
//  Created by Adrian Inculet on 15.03.2026.
//

import Foundation

@Observable
class WelcomeViewModel {
    var username: String = ""
    var isLogged = false
    var offset: CGFloat = 0
    var viewState = CGSize(width: 0, height: 50)
    var isNameValid: Bool {
        username.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
    }
}
