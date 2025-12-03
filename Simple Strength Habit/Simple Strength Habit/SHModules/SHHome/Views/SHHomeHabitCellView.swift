//
//  SHHomeHabitCellView.swift
//  Simple Strength Habit
//
//

import SwiftUI

struct SHHomeHabitCellView: View {
    @ObservedObject var viewModel: HabitViewModel
    @State var habit: Habit
    @State var editProgress = false
    @State private var progressText: String = ""
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(habit.name.text)
                    .font(.system(size: 23, weight: .semibold))
                    .foregroundStyle(.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                HStack(spacing: 20) {
                   
                    if editProgress {
                        TextField("", text: $progressText)
                            .keyboardType(.decimalPad)
                    } else {
                        
                        HStack(spacing: 4) {
                            Text("\(habit.progress)")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.text)
                                .multilineTextAlignment(.leading)
                            
                            Text("\(habit.name.unitOfMeasurement.shortText)")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.text)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    Button {
                        if editProgress {
                            if let newValue = Decimal(string: progressText, locale: Locale.current) {
                                
                                viewModel.editProgress(habit: habit, progress: min(newValue, habit.goal))
                                
                                
                            }
                        } else {
                            progressText = habit.progress.asString
                        }
                        
                        withAnimation {
                            editProgress.toggle()
                        }
                    } label: {
                        Image(systemName: "pencil.line")
                            .bold()
                            .foregroundStyle(.text)
                    }
                    
                    
                }
                .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(.tabBar.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            
            
            HabitProgressBar(progress: habit.progress, goal: habit.goal)
                .overlay {
                    Text("\(habit.goal) \(habit.name.unitOfMeasurement.shortText)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                }
            
        }
        .padding()
        .background(.cellBg)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .hideKeyboardOnTap()
    }
    
    func decimalToString(_ value: Decimal,
                         maximumFractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale.current
        
        return formatter.string(from: value as NSDecimalNumber) ?? ""
    }
}

#Preview {
    SHHomeHabitCellView(viewModel: HabitViewModel(), habit: Habit(name: .waterIntake, goal: 2.5, progress: 0, type: .quantitative, isCompleted: true))
}

extension Decimal {
    var asString: String {
        NSDecimalNumber(decimal: self).stringValue
    }
}
