//
//  FlexLogApp.swift
//  FlexLog
//
//  Created by Adrian Inculet on 22.02.2026.
//

import SwiftUI

@main
struct FlexLogApp: App {
    
    @State var session = UserSession()
    
    var body: some Scene {
        WindowGroup {
            if session.currentUser == nil {
                WelcomeView()
                    .environment(session)
            }
            else {
                HomeView()
                    .environment(session)
            }
        }
    }
}
