//
//  ExerciseView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 03.03.2026.
//

import SwiftUI

struct ExerciseView: View {
    
    enum Field: Hashable {
        case exerciseName, sets, reps, weight
    }
    
    @Binding var workout: Workout
    @State private var viewModel = ExerciseViewModel()
    @AppStorage("measure_unit") private var measureUnit: MeasureUnitModel = .kg
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            
            VStack {
                Text("Add exercises to your \(workout.title)!")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(Color.text)
                
                HStack {
                    ColumnView(text: $viewModel.exerciseName, label: "Exercise Name", width: nil)
                        .focused($focusedField, equals: .exerciseName)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .sets }
                    
                    ColumnView(text: $viewModel.sets, label: "Sets", width: 60)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .sets)
                    
                    ColumnView(text: $viewModel.reps, label: "Reps", width: 60)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .reps)
                    
                    ColumnView(text: $viewModel.weight, label: measureUnit.rawValue, width: 60)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .weight)
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top)
                
                Button {
                    viewModel.addExercise(to: $workout)
                    viewModel.resetInputs()
                    focusedField = nil
                } label: {
                    Text("Add Exercise")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(viewModel.isInputValid ? Color.button : Color.gray.opacity(0.3))
                        .foregroundStyle(viewModel.isInputValid ? .white : .white.opacity(0.5))
                        .cornerRadius(10)
                }
                .animation(.easeInOut, value: viewModel.isInputValid)
                .disabled(!viewModel.isInputValid)
                .padding()
                
                List {
                    ForEach(workout.exercises) { exercise in
                        ExerciseRowView(
                            name: exercise.name,
                            sets: exercise.sets,
                            reps: exercise.reps,
                            weight: exercise.weight
                        )
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                    }
                    .onDelete { index in
                        workout.exercises.remove(atOffsets: index)
                    }
                }
                .listRowSpacing(10)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.appBackground)
                .scrollDismissesKeyboard(.interactively)
                
                Spacer()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focusedField = nil
                }
            }
        }
    }
}

#Preview {
    ExerciseView(workout: .constant(Workout(
            title: "Push day",
            exercises: [Exercise(id: UUID(), name: "Bench Press", sets: 3, reps: 10, weight: 60)]
        )))}
