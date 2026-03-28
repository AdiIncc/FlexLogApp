//
//  ListCellView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 24.02.2026.
//

import SwiftUI

struct ListCellView: View {
    @Binding var workout: Workout
    let onShowExercises: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
                .frame(height: 100)
                .overlay(
                    VStack(spacing: 0) {
                        HStack(alignment: .center) {
                            Text(workout.createdDate)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.white)
                            Spacer()
                            Button {
                                onShowExercises()
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxHeight: .infinity)
                        
                        Rectangle()
                            .fill(.white)
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                        
                        HStack(alignment: .center) {
                            Text(workout.title)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            Spacer()
                            Image(systemName: workout.isCompleted ? "checkmark.circle" : "circle")
                                .font(.system(size: 20))
                                .foregroundStyle(workout.isCompleted ? .green : .white)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        workout.isCompleted.toggle()
                                    }
                                }
                        }
                        .padding(.horizontal)
                        .frame(maxHeight: .infinity)
                    }
                )
                .padding(.horizontal)
        }
    }
}


#Preview {
    ListCellView(workout: .constant(Workout(title: "aeag", date: Date(), isCompleted: false, exercises: [Exercise(id: UUID(), name:"aage", sets: 1, reps: 2, weight: 34)])), onShowExercises: {})
}
