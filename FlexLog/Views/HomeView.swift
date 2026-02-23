//
//  HomeView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 22.02.2026.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("username") var username: String = ""
    @State var isMenuOpen: Bool = false
    
    fileprivate func MenuView() -> some View {
        ZStack(alignment: .trailing) {
            
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    Spacer()
                    Rectangle()
                        .fill(Color.menuBackground)
                        .frame(width: proxy.size.width / 2.1)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: -20)
                }
            }
            .transition(.move(edge: .trailing))
        }
        .ignoresSafeArea()
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        VideoControllerView(videoName: "gymVideo")
                        Spacer()
                    }
                }
                .blur(radius: isMenuOpen ? 5 : 0)
                if isMenuOpen {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isMenuOpen = false
                            }
                        }
                        .transition(.opacity)
                    MenuView()
                        .transition(.move(edge: .trailing))
                        .zIndex(1)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.easeInOut) {
                            isMenuOpen.toggle()
                        }
                    }
                    label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.white)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
