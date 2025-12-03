//
//  AverageHabitProgressDonut.swift
//  Simple Strength Habit
//
//

import SwiftUI

struct AverageHabitProgressDonut: View {
    let habits: [Habit]

    var body: some View {
        let value = averageCompletion(for: habits)
        let percent = Int((value * 100).rounded())

        ZStack {
            // Серый фон-кольцо
            Circle()
                .stroke(
                    Color.cellBg,
                    lineWidth: 25
                )

            // Заполненная часть
            Circle()
                .trim(from: 0, to: value) // 0...1
                .stroke(
                    .tabBar,
                    style: StrokeStyle(
                        lineWidth: 25,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90)) // чтобы начиналось сверху
                .animation(.easeOut(duration: 0.4), value: value)

            // Текст в центре
            VStack(spacing: 10) {
                Text("Today")
                    .font(.system(size: 25, weight: .black))
                    .foregroundColor(.text)
                    .textCase(.uppercase)
                
                Text("\(percent)%")
                    .font(.system(size: 45, weight: .semibold))
                    .foregroundColor(.percentText)
                
            }
        }
        .frame(width: 200, height: 200)
    }
    
    func averageCompletion(for habits: [Habit]) -> Double {
        let validHabits = habits.filter { $0.goal > 0 }
        guard !validHabits.isEmpty else { return 0 }
        
        let total = validHabits.reduce(0.0) { partial, habit in
            let ratio = habit.progress.doubleValue / habit.goal.doubleValue
            let clamped = max(0, min(ratio, 1))
            return partial + clamped
        }
        
        return total / Double(validHabits.count)
    }
}
