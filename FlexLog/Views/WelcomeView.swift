//
//  ContentView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 22.02.2026.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(UserSession.self) var session: UserSession
    @State private var username: String = ""
    @State private var isLogged = false
    @State private var offset: CGFloat = 0
    @State var viewState = CGSize(width: 0, height: 50)
    var isNameValid: Bool {
        username.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
    }
    let horizontalPadding: CGFloat = 15
    let buttonSize: CGFloat = 70
    
    var body: some View {
        GeometryReader { proxy in
            let totalWidth = proxy.size.width - (horizontalPadding * 2)
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.primaryBackground, Color.secondaryBackground]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack() {
                    Text("Welcome to FlexLog")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.text)
                        .padding(.bottom, 15)
                    Text("Please enter your username!")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.text)
                    TextField("Username", text: $username)
                        .textFieldStyle(MainTextField())
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    Text("The username should be at least 3 characters long.")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.text)
                        .padding(.top, 5)
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white.opacity(0.9))
                            .frame(width: totalWidth, height: buttonSize + 10)
                        Text(isNameValid ? "Ready to crush it! " : "Enter username to start!")
                            .font(.footnote).bold()
                            .foregroundStyle(isNameValid ? Color.textValidation : Color.black)
                            .frame(width: totalWidth)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(isNameValid ? Color.button.opacity(0.7) : .black.opacity(0.7))
                                .frame(width: buttonSize, height: buttonSize)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white)
                                .font(.system(size: 24, weight: .bold))
                        }
                        .padding(.leading, 5)
                        .offset(x: offset)
                        .gesture(
                            isNameValid ?
                            DragGesture()
                            .onChanged({ value in
                                let maxOffSet = totalWidth - buttonSize - 10
                                if value.translation.width > 0 && value.translation.width <= maxOffSet {
                                    offset = value.translation.width
                                }
                            })
                                .onEnded({ value in
                                    let maxOffSet = totalWidth - buttonSize - 10
                                    if offset > maxOffSet * 0.8 {
                                        withAnimation(.spring()) {
                                            offset = maxOffSet
                                            session.currentUser = User(id: UUID(), username: username)
                                            isLogged = true
                                        }
                                    }
                                    else {
                                        withAnimation(.spring()) {
                                            offset = 0
                                        }
                                    }
                                })
                            : nil
                        )
                    }
                    .opacity(isNameValid ? 1.0 : 0.5)
                    .animation(.easeInOut, value: isNameValid)
                    .frame(width: totalWidth)
                    .padding(.top, 20)
                }
                .padding(.horizontal, 15)
            }
        }
        .fullScreenCover(isPresented: $isLogged) {
            HomeView()
        }
    }
}

#Preview {
    WelcomeView()
        .environment(UserSession())
}
