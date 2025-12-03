//
//  SHStatisticsView.swift
//  Simple Strength Habit
//
//

import SwiftUI

struct SHStatisticsView: View {
    @ObservedObject var viewModel: HabitViewModel
    @State private var selectedPeriod: HabitPeriod = .day
    
    private let columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Statistics")
                .font(.system(size: 25, weight: .black))
                .foregroundStyle(.text)
                .textCase(.uppercase)
            
            PeriodTabView(selection: $selectedPeriod)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 21) {
                    switch selectedPeriod {
                    case .day:
                        LazyVGrid(columns: columns) {
                            ForEach(todayHabits, id: \.self) { habit in
                                VStack(spacing: 7) {
                                    DayHabitProgressDonut(habit: habit)
                                        .frame(width: 120, height: 140)
                                    
                                    Text(habit.name.text)
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundStyle(.text)
                                    
                                }.frame(height: 200, alignment: .top)
                                    .padding()
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .shadow(radius: 5)
                            }
                        }
                        
                    case .month:
                        MonthAllHabitsChartsView(habits: viewModel.habits)
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(radius: 5)
                            .padding(.horizontal, 5)
                    }
                }.frame(maxWidth: .infinity)
                .padding(.top).padding(.bottom, 100)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(25)
    }
    
    var todayHabits: [Habit] {
        viewModel.habits.filter { Calendar.current.isDateInToday($0.date) }
    }
    
    var monthHabits: [Habit] {
        let calendar = Calendar.current
        let now = Date()
        return viewModel.habits.filter {
            calendar.isDate($0.date, equalTo: now, toGranularity: .month)
        }
    }
    
}

#Preview {
    SHStatisticsView(viewModel: HabitViewModel())
}



import Charts
import SwiftUI


struct HabitMonthPoint: Identifiable {
    let id = UUID()
    let day: Int       
    let progress: Double
}

func monthPoints(from habits: [Habit]) -> [HabitMonthPoint] {
    let calendar = Calendar.current
    let now = Date()

    guard let monthInterval = calendar.dateInterval(of: .month, for: now) else {
        return []
    }

    let monthHabits = habits.filter { habit in
        monthInterval.contains(habit.date)
    }


    return monthHabits.map { habit in
        let day = calendar.component(.day, from: habit.date)

        return HabitMonthPoint(
            day: day,
            progress: habit.progress.doubleValue
        )
    }
}

struct MonthHabitBarChart: View {
    let habitName: HabitName
    let habits: [Habit]
    
    private var calendar: Calendar { Calendar.current }
    
    private var points: [HabitMonthPoint] {
        let grouped = Dictionary(grouping: habits) { habit in
            calendar.component(.day, from: habit.date)
        }
        
        return grouped.compactMap { (day, habitsInDay) in
            guard let latest = habitsInDay.max(by: { $0.date < $1.date }) else {
                return nil
            }
            
            return HabitMonthPoint(
                day: day,
                progress: latest.progress.doubleValue
            )
        }
        .sorted { $0.day < $1.day }
    }
    
    private var daysRange: ClosedRange<Int> {
        let date = habits.first?.date ?? Date()
        let range = calendar.range(of: .day, in: .month, for: date) ?? Range(1...30)
        return range.lowerBound...range.upperBound
    }
    
    private var xAxisTickValues: [Int] {
        let first = daysRange.lowerBound
        let last = daysRange.upperBound
        let middle = min(15, last)
        
        var result: [Int] = []
        for v in [first, middle, last] {
            if !result.contains(v) {
                result.append(v)
            }
        }
        return result
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Chart(points) { point in
                BarMark(
                    x: .value("Day", point.day),
                    y: .value("Progress", point.progress),
                    width: .fixed(13)
                ).clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 10))
                    .foregroundStyle(.text)
            }
            .chartXScale(domain: daysRange)
            .chartXAxis {
                AxisMarks(values: xAxisTickValues) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel {
                        if let day = value.as(Int.self) {
                            Text("\(day)")
                                .foregroundStyle(.tabBar)
                        }
                    }
                }
            }
            .frame(height: 100)
        }
    }
}


struct MonthAllHabitsChartsView: View {
    let habits: [Habit]

    private var groupsForCurrentMonth: [(habitName: HabitName, habits: [Habit])] {
        let calendar = Calendar.current
        let now = Date()

        guard let monthInterval = calendar.dateInterval(of: .month, for: now) else {
            return []
        }

        let monthHabits = habits.filter { habit in
            monthInterval.contains(habit.date)
        }

        let grouped = Dictionary(grouping: monthHabits, by: \.name)

        return grouped
            .map { (habitName: $0.key, habits: $0.value) }
            .sorted { $0.habitName.text < $1.habitName.text }
    }

    var body: some View {
        ScrollView {
            if groupsForCurrentMonth.isEmpty {
                Text("No data")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.secondaryText)
            } else {
                VStack(alignment: .leading, spacing: 24) {
                    
                    ForEach(groupsForCurrentMonth, id: \.habitName) { group in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(group.habitName.text)   
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.text)
                            
                            MonthHabitBarChart(
                                habitName: group.habitName,
                                habits: group.habits
                            )
                        }
                        
                        if group != groupsForCurrentMonth.last! {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundStyle(.tabBar)
                        }
                    }
                    
                }
                .padding()
            }
        }
    }
}
