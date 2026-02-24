//
//  HomeView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 22.02.2026.
//

import SwiftUI

struct HomeView: View {
    
    @State var isMenuOpen: Bool = false
    @State var addWorkoutIsPresented: Bool = false
    @State var workouts: [Workout] = [Workout(title: "Arms/Legs", date: Date(), isCompleted: false, exercises: [Exercise(name: "Barbell Curl", sets: 2, reps: 8, weight: 20)])]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.appBackground
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Text("Workouts")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundStyle(Color.text)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom)
                    ScrollView {
                        LazyVStack {
                            VideoControllerView(videoName: "gymVideo")
                            ForEach($workouts) { workout in
                                ListCellView(workout: workout)
                            }
                        }
                        .padding(.bottom, 100)
                    }
                    .overlay(alignment: .bottom) {
                        Button {
                            addWorkoutIsPresented = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .medium))
                                .padding(20)
                                .foregroundStyle(.white)
                                .background(Color.button)
                                .clipShape(Circle())
                        }
                        .sheet(isPresented: $addWorkoutIsPresented) {
                            AddWorkoutView()
                        }
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
                    SettingsView(isMenuOpen: $isMenuOpen)
                        .transition(.move(edge: .trailing))
                        .zIndex(1)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.spring()) {
                            isMenuOpen.toggle()
                        }
                    }
                    label: {
                        Image(systemName: isMenuOpen ? "xmark" : "line.3.horizontal")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
