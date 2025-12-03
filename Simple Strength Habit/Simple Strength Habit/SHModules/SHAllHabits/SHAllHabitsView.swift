//
//  SHAllHabitsView.swift
//  Simple Strength Habit
//
//

import SwiftUI

struct SHAllHabitsView: View {
    @ObservedObject var viewModel: HabitViewModel
    @State var showEditView = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("all habits")
                .font(.system(size: 25, weight: .black))
                .foregroundStyle(.text)
                .textCase(.uppercase)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 21) {
                    ForEach(viewModel.habits, id: \.self) { habit in
                        SHHabitCell(viewModel: viewModel, habit: habit) {
                        }
                    }
                }.padding(.top).padding(.bottom, 100)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(25)
        .overlay(alignment: .bottomTrailing) {
            NavigationLink {
                SHCreateHabitView(viewModel: viewModel)
                    .navigationBarBackButtonHidden()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 32)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(.text)
                    .clipShape(Circle())
                    .padding(.trailing, 25)
                    .padding(.bottom, 120)
            }
        }
        
    }
}

#Preview {
    SHAllHabitsView(viewModel: HabitViewModel())
}
