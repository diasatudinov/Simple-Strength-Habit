//
//  SHHabitCell.swift
//  Simple Strength Habit
//
//

import SwiftUI

struct SHHabitCell: View {
    @ObservedObject var viewModel: HabitViewModel
    @State var habit: Habit
    var onEditPressed: () -> ()
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habit.name.text)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(habit.goal) \(habit.name.unitOfMeasurement.shortText)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.secondaryText)
            }
            
            Toggle("", isOn: $habit.isCompleted)
                .labelsHidden()
                .tint(.text)
                .allowsHitTesting(false)
        }
        .padding(.horizontal, 35)
        .padding(.vertical, 13)
        .background(.cellBg)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(alignment: .topLeading) {
            NavigationLink {
                SHEditHabitView(viewModel: viewModel, habit: habit)
                    .navigationBarBackButtonHidden()
                
            } label: {
                
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .padding(2)
                    .frame(height: 24)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(4)
                    .background(.text)
                    .clipShape(Circle())
                    .offset(y: -16)
            }
        }
    }
}

#Preview {
    SHHabitCell(viewModel: HabitViewModel(), habit:
                    Habit(name: .waterIntake, goal: 2.5, progress: 0, type: .quantitative, isCompleted: true), onEditPressed: {}
    )
}
