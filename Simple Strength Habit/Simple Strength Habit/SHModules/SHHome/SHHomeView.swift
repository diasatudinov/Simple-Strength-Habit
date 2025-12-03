//
//  SHHomeView.swift
//  Simple Strength Habit
//
//

import SwiftUI

struct SHHomeView: View {
    @ObservedObject var viewModel: HabitViewModel
    @State private var editProgress = false
    
    var body: some View {
            VStack(alignment: .leading, spacing: 17) {
                let todayHabits = viewModel.habits.filter { habit in
                    Calendar.current.isDateInToday(habit.date)
                }
                
                Text("Menu")
                    .font(.system(size: 25, weight: .black))
                    .foregroundStyle(.text)
                    .textCase(.uppercase)
                
                AverageHabitProgressDonut(habits: todayHabits)
                    .frame(maxWidth: .infinity)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 21) {
                        ForEach(todayHabits, id: \.self) { habit in
                            if habit.type == .quantitative {
                                SHHomeHabitCellView(viewModel: viewModel, habit: habit)
                            } else {
                                HStack {
                                    Text(habit.name.text)
                                        .font(.system(size: 23, weight: .semibold))
                                        .foregroundStyle(.text)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Button {
                                        withAnimation {
                                            viewModel.toggleHabitComplete(habit: habit)
                                        }
                                    } label: {
                                        
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(lineWidth: 2)
                                            .foregroundStyle(habit.isCompleted ? .text : .tabBar)
                                            .frame(width: 32, height: 32)
                                            .padding(.horizontal)
                                            .overlay {
                                                if habit.isCompleted {
                                                    Image(systemName: "checkmark")
                                                        .bold()
                                                        .foregroundStyle(.text)
                                                }
                                            }
                                           
                                    }
                                    
                                }
                                .padding()
                                .background(.cellBg)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }.padding(.top).padding(.bottom, 100)
                }
                .navigationDestination(for: Habit.self) { habit in
                    SHEditHabitView(viewModel: viewModel, habit: habit)
                        .navigationBarBackButtonHidden()
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(25)
    }
}

#Preview {
    SHHomeView(viewModel: HabitViewModel())
}
