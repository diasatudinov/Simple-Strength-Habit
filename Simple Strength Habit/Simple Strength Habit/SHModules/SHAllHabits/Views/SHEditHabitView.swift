//
//  SHEditHabitView.swift
//  Simple Strength Habit
//
//

import SwiftUI

struct SHEditHabitView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: HabitViewModel
    @State var habit: Habit
    
    @State private var name: HabitName = .waterIntake
    @State private var unitOfMeasurement: UnitOfMeasurement = .liters
    @State private var goal: String = ""
    @State private var type: HabitType = .quantitative
    
    @State private var showListHabitName = false
    @State private var showListHabitType = false
    var body: some View {
        VStack {
            header()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 34) {
                    
                    VStack(spacing: 34) {
                        VStack {
                            cell(text: name.text, rotationBool: showListHabitName)
                                .onTapGesture {
                                    withAnimation {
                                        showListHabitName.toggle()
                                    }
                                }
                            
                            if showListHabitName {
                                
                                VStack(spacing: 0) {
                                    ScrollView(showsIndicators: false) {
                                        ForEach(HabitName.allCases, id: \.self) { name in
                                            VStack {
                                                Text(name.text)
                                                    .font(.system(size: 20, weight: .semibold))
                                                    .foregroundStyle(.text)
                                                    .padding(.vertical, 5)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .onTapGesture {
                                                        self.name = name
                                                        withAnimation {
                                                            showListHabitName.toggle()
                                                        }
                                                    }
                                                
                                                if name != HabitName.allCases.last {
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .frame(height: 2)
                                                        .foregroundStyle(.text)
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(height: 180)
                                .padding(.vertical)
                                .padding(.horizontal)
                                .background(.cellBg)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                        }
                        
                        cell(text: name.unitOfMeasurement.text, showChevron: false)
                        
                        HStack {
                            TextField("", text: $goal)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.text)
                                .keyboardType(.decimalPad)
                            
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 20)
                        .background(.cellBg)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        VStack {
                            cell(text: type.text, rotationBool: showListHabitType)
                                .onTapGesture {
                                    withAnimation {
                                        showListHabitType.toggle()
                                    }
                                }
                            
                            if showListHabitType {
                                VStack(spacing: 0) {
                                    ForEach(HabitType.allCases, id: \.self) { name in
                                        VStack {
                                            Text(name.text)
                                                .font(.system(size: 20, weight: .semibold))
                                                .foregroundStyle(.text)
                                                .padding(.vertical, 5)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .onTapGesture {
                                                    self.type = name
                                                    withAnimation {
                                                        showListHabitType.toggle()
                                                    }
                                                }
                                            
                                            if name != HabitType.allCases.last {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(height: 2)
                                                    .foregroundStyle(.text)
                                            }
                                        }
                                    }
                                }
                                .padding(.vertical)
                                .padding(.horizontal)
                                .background(.cellBg)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                        }
                    }
                    
                }
                .padding(.top, 30)
                .padding(.bottom, 350)
                    
            }
            .overlay(alignment: .bottom) {
                
                VStack {
                    Button {
                        if goal != "" {
                            viewModel.edit(
                                habit: habit,
                                habitName: name,
                                habitGoal: Decimal(string: goal) ?? 0.0,
                                habitType: type
                            )
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 15)
                            .background(.text.opacity(goal == "" ? 0.5 : 1))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    }
                    
                    Button {
                        viewModel.delete(habit: habit)
                            dismiss()
                        
                    } label: {
                        Text("Delete")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 15)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    }
                }.padding(.bottom, 20)
            }
        }.padding(.horizontal, 27)
            .onAppear {
                name = habit.name
                unitOfMeasurement = habit.name.unitOfMeasurement
                goal = decimalToString(habit.goal)
                type = habit.type
            }
    }
    
    private func header() -> some View {
        HStack(spacing: 10) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .bold()
            }
            Spacer()
            
            Text("Edit habit")
                .font(.system(size: 25, weight: .black))
                .textCase(.uppercase)
            
            Spacer()
            
            Rectangle()
                .frame(width: 20, height: 20)
                .foregroundStyle(.clear)
        }.foregroundStyle(.text)
    }
    
    private func cell(text: String, showChevron: Bool = true, rotationBool: Bool = true) -> some View {
        HStack {
            Text(text)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.text)
            Spacer()
            
            if showChevron {
                Image(systemName: "chevron.down")
                    .bold()
                    .rotationEffect(Angle(degrees: rotationBool ? 0 : -90))
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 20)
        .background(.cellBg)
        .clipShape(RoundedRectangle(cornerRadius: 15))
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
    SHEditHabitView(viewModel: HabitViewModel(), habit: Habit(name: .flexibility, goal: 20, progress: 0, type: .quantitative))
}
