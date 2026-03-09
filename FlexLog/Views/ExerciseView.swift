//
//  ExerciseView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 03.03.2026.
//

import SwiftUI

struct ExerciseView: View {
    
    @Binding var workout: Workout
    @State var addedExercises: [Exercise] = []
    @State var exerciseName: String = ""
    @State var sets: String = ""
    @State var reps: String = ""
    @State var weight: String = ""
    @AppStorage("measure_unit") private var measureUnit: MeasureUnitModel = .kg
    
    var isInputValid: Bool {
        !exerciseName.isEmpty &&
        Int(sets) != nil &&
        Int(reps) != nil &&
        Double(weight.replacingOccurrences(of: ",", with: ".")) != nil
    }
    
    init(workout: Binding<Workout>) {
            self._workout = workout
            self._addedExercises = State(initialValue: workout.wrappedValue.exercises)
        }
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            VStack {
                Text("Add exercises to your \(workout.title)!")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(Color.text)
                HStack {
                    ColumnView(text: $exerciseName, label: "Exercise Name", width: nil)
                    ColumnView(text: $sets, label: "Sets", width: 60)
                        .keyboardType(.numberPad)
                    ColumnView(text: $reps, label: "Reps", width: 60)
                        .keyboardType(.numberPad)
                    ColumnView(text: $weight, label: measureUnit.rawValue, width: 60)
                        .keyboardType(.decimalPad)
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top)
                Button {
                    if let sets = Int(sets), let reps = Int(reps), let weight = Double(weight.replacingOccurrences(of: ",", with: ".")), !exerciseName.isEmpty {
                        withAnimation(.spring()) {
                            let newExercise = Exercise(name: exerciseName, sets: sets, reps: reps, weight: weight)
                            addedExercises.append(newExercise)
                            workout.exercises.append(newExercise)
                        }
                        self.exerciseName = ""
                        self.sets = ""
                        self.reps = ""
                        self.weight = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                } label: {
                    Text("Add Exercise")
                        .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(isInputValid ? Color.button : Color.gray.opacity(0.3))
                                .foregroundStyle(isInputValid ? .white : .white.opacity(0.5))
                                .cornerRadius(10)
                    
                }
                .animation(.easeInOut, value: isInputValid)
                .disabled(!isInputValid)
                .padding()
                List {
                        ForEach(addedExercises) { exercise in
                                ExerciseRowView(name: exercise.name, sets: exercise.sets, reps: exercise.reps, weight: exercise.weight)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                            }
                        .onDelete { index in
                            addedExercises.remove(atOffsets: index)
                            workout.exercises.remove(atOffsets: index)
                        }
                    }
                    .listRowSpacing(10)
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.appBackground)
                Spacer()
            }
           
            .onAppear {
                addedExercises = workout.exercises
            }
        }
    }
}

#Preview {
    ExerciseView(workout: .constant(Workout(
            title: "Push day",
            exercises: [Exercise(name: "Bench Press", sets: 3, reps: 10, weight: 60)]
        )))}
