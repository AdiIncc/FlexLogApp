//
//  MeasureUnitModel.swift
//  FlexLog
//
//  Created by Adrian Inculet on 08.03.2026.
//

import Foundation

enum MeasureUnitModel: String, CaseIterable, Identifiable {
    case kg, lbs
    
    var id: String { self.rawValue}
}
