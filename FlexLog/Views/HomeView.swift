//
//  HomeView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 22.02.2026.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isMenuOpen: Bool = false
    @State private var showStatistics: Bool = false
    @State private var addWorkoutIsPresented: Bool = false
    @State private var workouts: [Workout] = [Workout(title: "Arms/Legs", date: Date(), isCompleted: false, exercises: [Exercise(name: "Barbell Curl", sets: 2, reps: 8, weight: 20)])]
    
        var body: some View {
            NavigationStack {
                ZStack(alignment: .bottom) {
                    Color.appBackground
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        Text("Workouts")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundStyle(Color.text)
                            .padding(.bottom)
                        List {
                            VideoControllerView(videoName: "gymVideo")
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                            ForEach($workouts) { $workout in
                                ListCellView(workout: $workout)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                            }
                            .onDelete { indexSet in
                                workouts.remove(atOffsets: indexSet)
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .background(Color.appBackground)
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
                            AddWorkoutView(workouts: $workouts)
                                .presentationDragIndicator(.visible)
                        }
                    }
                    if isMenuOpen {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.easeInOut) { isMenuOpen = false }
                            }
                        SettingsView(isMenuOpen: $isMenuOpen, showStatistics: $showStatistics)
                            .transition(.move(edge: .trailing))
                            .zIndex(1)
                    }
                }
                .fullScreenCover(isPresented: $showStatistics, content: {
                    StatisticsView(workouts: $workouts)
                })
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation(.spring()) { isMenuOpen.toggle() }
                        } label: {
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
        .environment(UserSession())
}
