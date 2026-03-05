//
//  AddWorkoutView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 23.02.2026.
//

import SwiftUI

struct AddWorkoutView: View {
    @Binding var workouts: [Workout]
    @State private var workoutTitle: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.appBackground, Color.addViewBackground], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Text("Create Your Workout")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(Color.text)
                    .padding(.top, 20)
                Spacer()
                Text("Today's Workout Name")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.text)
                TextField("Title", text: $workoutTitle)
                    .textFieldStyle(MainTextField())
                Button {
                    if !workoutTitle.isEmpty {
                        let newWorkout = Workout(title: workoutTitle)
                        workouts.append(newWorkout)
                        dismiss()
                    }
                } label: {
                    Text("Create Workout")
                }
                .buttonStyle(ButtonCustomStyle())
                .padding(.top, 20)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    AddWorkoutView(workouts: .constant([]))
}
