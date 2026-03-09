//
//  StatisticsView.swift
//  FlexLog
//
//  Created by Adrian Inculet on 09.03.2026.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @Binding var workouts: [Workout]
    @State private var selectedRange: TimeRange = .week
    @AppStorage("measure_unit") private var measureUnit: MeasureUnitModel = .kg
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.trailing)
                    Text("Statistics")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundStyle(Color.text)
                        .padding(.vertical)
                    ScrollView {
                        VStack(spacing: 10) {
                            Picker("Range", selection: $selectedRange) {
                                ForEach(TimeRange.allCases) { range in
                                    Text(range.rawValue).tag(range)
                                }
                            }
                            .pickerStyle(.segmented)
                            .colorScheme(.dark)
                            .padding(.horizontal)
                            volumeProgress
                            recordsSection
                        }
                        .padding()
                    }
                }
            }
    }
    var filteredWorkout: [Workout] {
        let now = Date()
        let calendar = Calendar.current
        
        return workouts.filter { workout in
            switch selectedRange {
            case .week:
                return calendar.dateComponents([.day], from: workout.date, to: now).day ?? 8 < 7
            case .month:
                return calendar.dateComponents([.month], from: workout.date, to: now).month ?? 1 < 1
            case .year:
                return calendar.dateComponents([.year], from: workout.date, to: now).year ?? 1 < 1
            }
        }
    }
    
    var volumeProgress: some View {
        VStack(alignment: .leading) {
            Text("Volume Progress")
                .font(.headline)
                .foregroundStyle(.gray)
            Chart(filteredWorkout) { workout in
                BarMark(x: .value("Date", workout.date, unit: selectedRange == .year ? .month : .day), y: .value("Volume", workout.totalVolume),width: .fixed(20))
                    .foregroundStyle(.button.gradient)
                    .cornerRadius(4)
            }
            .frame(height: 220)
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { _ in
                    AxisGridLine().foregroundStyle(.white.opacity(0.1))
                    AxisValueLabel().foregroundStyle(.text)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { _ in
                    AxisGridLine().foregroundStyle(.white.opacity(0.1))
                    AxisValueLabel().foregroundStyle(.text)
                }
            }
        }
        .padding()
        .background(.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    var recordsSection: some View {
        HStack {
            Text("Total Period Volume")
                .foregroundStyle(.text)
            Spacer()
            Text("\(Int(filteredWorkout.reduce(0) { $0 + $1.totalVolume })) \(measureUnit.rawValue.uppercased())")
                .bold()
                .foregroundStyle(.text)
        }
        .padding()
        .background(.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    StatisticsView(workouts: .constant([]))
}
