//
//  Exercise.swift
//  FlexLog
//
//  Created by Adrian Inculet on 24.02.2026.
//

import Foundation

struct Exercise: Identifiable, Equatable {
    let id: UUID
    var name: String
    var sets: Int
    var reps: Int
    var weight: Double
}
