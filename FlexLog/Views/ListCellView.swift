//
//  ListCellView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 24.02.2026.
//

import SwiftUI

struct ListCellView: View {
    
    @Binding var workout: Workout
    
    var body: some View {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.1))
                    .frame(height: 100)
                    .overlay(
                        HStack(alignment: .center, content: {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(workout.createdDate)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .padding(.top)
                                Text(workout.title)
                                    .font(.system(size: 16, weight: .semibold))
                                    .lineLimit(1)
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            
                            Spacer()
                            Image(systemName: workout.isCompleted ? "checkmark.circle" : "circle")
                                .font(.system(size: 20))
                                .foregroundStyle(workout.isCompleted ? .green : .white)
                                .scaleEffect(workout.isCompleted ? 1.2 : 1.0)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        workout.isCompleted.toggle()
                                    }
                                }
                        })
                        .padding()
                    )
                    .padding(.horizontal)
    }
}

#Preview {
    ListCellView(workout: .constant(Workout(title: "aeag", date: Date(), isCompleted: false, exercises: [Exercise(name:"aage", sets: 1, reps: 2, weight: 34)])))
}
