//
//  SettingsView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 23.02.2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(UserSession.self) var session: UserSession
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    Spacer()
                    Rectangle()
                        .fill(Color.menuBackground)
                        .frame(width: proxy.size.width / 2.1)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: -20)
                        .ignoresSafeArea()
                        .overlay {
                            VStack {
                                Text("Hi, \(session.currentUser?.username ?? "Guest")")
                                    .foregroundStyle(Color.text)
                                    .font(.system(size: 20, weight: .bold))
                                Rectangle()
                                    .fill(.white)
                                    .frame(height: 1)
                                Text("Settings")
                                    .foregroundStyle(Color.text)
                                Spacer()
                            }
                        }
                }
            }
            .transition(.move(edge: .trailing))
        }
    }
}

#Preview {
    SettingsView(isMenuOpen: .constant(true))
        .environment(UserSession())
}
