//
//  AverageHabitProgressDonut.swift
//  Simple Strength Habit
//
//


import SwiftUI

struct DayHabitProgressDonut: View {
    let habit: Habit

    var body: some View {
        let value = progressData(for: habit)
        let percent = Int((value * 100).rounded())

        ZStack {
            Circle()
                .stroke(
                    Color.cellBg,
                    lineWidth: 15
                )

            Circle()
                .trim(from: 0, to: value)
                .stroke(
                    .tabBar,
                    style: StrokeStyle(
                        lineWidth: 15,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.4), value: value)

            VStack(spacing: 10) {
                Text("\(percent)%")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.tabBar)
                
            }
        }
    }
    
    func progressData(for habit: Habit) -> Double {
        return habit.progress.doubleValue / habit.goal.doubleValue
    }
}
