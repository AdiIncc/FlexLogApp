//
//  ExerciseView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 03.03.2026.
//

import SwiftUI

struct ExerciseView: View {
    
    @Binding var workout: Workout
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            VStack {
                Text("Add exercises to your \(workout.title)!")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(Color.text)
                HStack {
                    ColumnView(label: "Exercise Name", width: nil)
                    ColumnView(label: "Sets", width: 60)
                    ColumnView(label: "Reps", width: 60)
                    ColumnView(label: "Kgs", width: 60)
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top)
                Button {
                    
                } label: {
                    Text("Add Exercise")
                    
                }
                .buttonStyle(ButtonCustomStyle())
                .padding()
                ScrollView {
                    
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ExerciseView(workout: .constant(Workout(title: "Push day", date: Date(), isCompleted: false, exercises: [Exercise(name:"aage", sets: 1, reps: 2, weight: 34)])))
}
