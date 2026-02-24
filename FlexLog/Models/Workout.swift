//
//  Workout.swift
//  FlexLog
//
//  Created by Adrian Inculet on 24.02.2026.
//

import Foundation

struct Workout: Identifiable {
    let id = UUID()
    var title: String
    var date: Date
    var isCompleted: Bool
    var exercises: [Exercise]
    
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
}
