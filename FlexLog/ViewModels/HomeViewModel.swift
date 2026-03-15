//
//  HomeViewModel.swift
//  FlexLog
//
//  Created by Adrian Inculet on 15.03.2026.
//

import Foundation

@Observable
class HomeViewModel {
    var isMenuOpen: Bool = false
    var showStatistics: Bool = false
    var addWorkoutIsPresented: Bool = false
    var workouts: [Workout] = [Workout(title: "Arms/Legs", date: Date(), isCompleted: false, exercises: [Exercise(name: "Barbell Curl", sets: 2, reps: 8, weight: 20)])]
}
