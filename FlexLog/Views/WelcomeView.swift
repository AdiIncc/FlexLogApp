//
//  ContentView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 22.02.2026.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(UserSession.self) var session: UserSession
    @State private var viewModel = WelcomeViewModel()
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
                    TextField("Username", text: $viewModel.username)
                        .textFieldStyle(MainTextField())
                    Text("The username should be at least 3 characters long.")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.text)
                        .padding(.top, 5)
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white.opacity(0.9))
                            .frame(width: totalWidth, height: buttonSize + 10)
                        Text(viewModel.isNameValid ? "Ready to crush it! " : "Enter username to start!")
                            .font(.footnote).bold()
                            .foregroundStyle(viewModel.isNameValid ? Color.textValidation : Color.black)
                            .frame(width: totalWidth)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(viewModel.isNameValid ? Color.button.opacity(0.7) : .black.opacity(0.7))
                                .frame(width: buttonSize, height: buttonSize)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white)
                                .font(.system(size: 24, weight: .bold))
                        }
                        .padding(.leading, 5)
                        .offset(x: viewModel.offset)
                        .gesture(
                            viewModel.isNameValid ?
                            DragGesture()
                            .onChanged({ value in
                                let maxOffSet = totalWidth - buttonSize - 10
                                if value.translation.width > 0 && value.translation.width <= maxOffSet {
                                    viewModel.offset = value.translation.width
                                }
                            })
                                .onEnded({ value in
                                    let maxOffSet = totalWidth - buttonSize - 10
                                    if viewModel.offset > maxOffSet * 0.8 {
                                        withAnimation(.spring()) {
                                            viewModel.offset = maxOffSet
                                            session.currentUser = User(id: UUID(), username: viewModel.username)
                                        }
                                    }
                                    else {
                                        withAnimation(.spring()) {
                                            viewModel.offset = 0
                                        }
                                    }
                                })
                            : nil
                        )
                    }
                    .opacity(viewModel.isNameValid ? 1.0 : 0.5)
                    .animation(.easeInOut, value: viewModel.isNameValid)
                    .frame(width: totalWidth)
                    .padding(.top, 20)
                }
                .padding(.horizontal, 15)
            }
        }

    }
}

#Preview {
    WelcomeView()
        .environment(UserSession())
}
