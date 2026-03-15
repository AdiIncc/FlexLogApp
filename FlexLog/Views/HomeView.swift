//
//  HomeView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 22.02.2026.
//

import SwiftUI

struct HomeView: View {
    
    @State private var viewModel = HomeViewModel()
    
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
                            ForEach($viewModel.workouts) { $workout in
                                ListCellView(workout: $workout)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                            }
                            .onDelete { indexSet in
                                viewModel.workouts.remove(atOffsets: indexSet)
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .background(Color.appBackground)
                        .padding(.bottom, 100)
                    }
                    .overlay(alignment: .bottom) {
                        Button {
                            viewModel.addWorkoutIsPresented = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .medium))
                                .padding(20)
                                .foregroundStyle(.white)
                                .background(Color.button)
                                .clipShape(Circle())
                        }
                        .sheet(isPresented: $viewModel.addWorkoutIsPresented) {
                            AddWorkoutView(workouts: $viewModel.workouts)
                                .presentationDragIndicator(.visible)
                        }
                    }
                    if viewModel.isMenuOpen {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.easeInOut) { viewModel.isMenuOpen = false }
                            }
                        SettingsView(isMenuOpen: $viewModel.isMenuOpen, showStatistics: $viewModel.showStatistics)
                            .transition(.move(edge: .trailing))
                            .zIndex(1)
                    }
                }
                .fullScreenCover(isPresented: $viewModel.showStatistics, content: {
                    StatisticsView(workouts: $viewModel.workouts)
                })
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation(.spring()) { viewModel.isMenuOpen.toggle() }
                        } label: {
                            Image(systemName: viewModel.isMenuOpen ? "xmark" : "line.3.horizontal")
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
