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
            // Серый фон-кольцо
            Circle()
                .stroke(
                    Color.cellBg,
                    lineWidth: 15
                )

            // Заполненная часть
            Circle()
                .trim(from: 0, to: value) // 0...1
                .stroke(
                    .tabBar,
                    style: StrokeStyle(
                        lineWidth: 15,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90)) // чтобы начиналось сверху
                .animation(.easeOut(duration: 0.4), value: value)

            // Текст в центре
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
