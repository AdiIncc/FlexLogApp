//
//  Workout.swift
//  FlexLog
//
//  Created by Adrian Inculet on 24.02.2026.
//

import Foundation

struct Workout: Identifiable, Equatable {
    
    let id: UUID
    var title: String
    var date: Date
    var isCompleted: Bool
    var exercises: [Exercise]
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.date == rhs.date &&
        lhs.isCompleted == rhs.isCompleted &&
        lhs.exercises == rhs.exercises
    }
    
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
    
    init(id: UUID = UUID(),title: String, date: Date = Date(), isCompleted: Bool = false, exercises: [Exercise] = []) {
        self.id = id
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
        self.exercises = exercises
    }
}

extension Workout {
    var totalVolume: Double {
        exercises.reduce(0) { sum, exercise in
            let sets = Double(exercise.sets)
            let reps = Double(exercise.reps)
            let weight = exercise.weight
            return sum + (sets * reps * weight)
        }
    }
}
