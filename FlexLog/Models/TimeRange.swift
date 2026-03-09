//
//  TimeRange.swift
//  FlexLog
//
//  Created by Adrian Inculet on 09.03.2026.
//

import Foundation

enum TimeRange: String, CaseIterable, Identifiable {
    case week = "Week"
    case month = "Month"
    case year = "Year"
    var id: String { self.rawValue }
}
