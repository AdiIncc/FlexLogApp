//
//  ExerciseViewModel.swift
//  FlexLog
//
//  Created by Adrian Inculet on 15.03.2026.
//

import Foundation
import SwiftUI

@Observable
class ExerciseViewModel {
    var exerciseName: String = ""
    var sets: String = ""
    var reps: String = ""
    var weight: String = ""
    var isInputValid: Bool {
        !exerciseName.isEmpty &&
        Int(sets) != nil &&
        Int(reps) != nil &&
        Double(weight.replacingOccurrences(of: ",", with: ".")) != nil
    }
    
    func addExercise(to workout: Binding<Workout>) {
        guard let sets = Int(sets),
              let reps = Int(reps),
              let weight = Double(weight.replacingOccurrences(of: ",", with: ".")) else {
            return
        }
        let newExercise = Exercise(name: exerciseName, sets: sets, reps: reps, weight: weight)
        withAnimation(.spring()) {
            workout.wrappedValue.exercises.append(newExercise)
        }
    }
    
    func resetInputs() {
        exerciseName = ""
        sets = ""
        reps = ""
        weight = ""
    }
}
