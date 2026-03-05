//
//  ExerciseRowView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 05.03.2026.
//

import Foundation
import SwiftUI

struct ExerciseRowView: View {
    let name: String
    let sets: Int
    let reps: Int
    let weight: Double
    
    var createdText: AttributedString {
        var result = AttributedString("\(sets) x \(reps) @ \(String(format: "%.1f", weight)) ")
        var weight = AttributedString("kg")
        weight.foregroundColor = .green
        weight.font = .system(size: 14, weight: .bold)
        result.append(weight)
        return result
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
           .fill(Color.white.opacity(0.1))
           .frame(height: 45)
           .overlay(content: {
               HStack {
                   Text(name)
                       .foregroundStyle(.text)
                       .bold()
                   Spacer()
                   Text(createdText)
                       .font(.system(size: 14, design: .monospaced))
                       .foregroundStyle(.gray)
               }
               .padding(.horizontal, 15)
           })
           .overlay(
           RoundedRectangle(cornerRadius: 8)
           .stroke(Color.white.opacity(0.3), lineWidth: 1)
           )
        }
    }
}
