//
//  HabitProgressBar.swift
//  Simple Strength Habit
//
//

import SwiftUI

struct HabitProgressBar: View {
    let progress: Decimal
    let goal: Decimal

    private var ratio: Double {
        guard goal > 0 else { return 0 }
        let value = progress.doubleValue / goal.doubleValue
        return max(0, min(value, 1))   
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.tabBar.opacity(0.2))

                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.tabBar)
                    .frame(width: geo.size.width * ratio)
            }
        }
        .frame(height: 20)  // высота прогресс-бара
    }
}
