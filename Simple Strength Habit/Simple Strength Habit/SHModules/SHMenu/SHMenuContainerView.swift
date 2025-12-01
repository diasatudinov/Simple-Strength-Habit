//
//  SHMenuContainerView.swift
//  Simple Strength Habit
//
//

import SwiftUI

struct SHMenuContainerView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                BBMenuView()
            }
        }
    }
}

struct BBMenuView: View {
    @State var selectedTab = 0
    @StateObject var habitViewModel = HabitViewModel()
    private let tabs = ["My dives", "Calendar", "Stats"]
    
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case 0:
                SHAllHabitsView(viewModel: habitViewModel)
            case 1:
                Color.yellow.ignoresSafeArea()
            case 2:
                Color.blue.ignoresSafeArea()
            case 3:
                Color.green.ignoresSafeArea()
            default:
                Text("default")
            }
            VStack(spacing: 0) {
                Spacer()
                
                HStack(spacing: 40) {
                    ForEach(0..<tabs.count) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            VStack {
                                Image(selectedTab == index ? selectedIcon(for: index) : icon(for: index))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 54)
                            }
                            
                        }
                        
                    }
                }
                .padding(.vertical, 13)
                .padding(.horizontal, 50)
                .frame(maxWidth: .infinity)
                .background(.tabBar)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, bottomLeadingRadius: 25, bottomTrailingRadius: 25, topTrailingRadius: 10))
                .padding(.bottom, 35)
                .padding(.horizontal, 25)
                
                
                
                
            }
            .ignoresSafeArea()
            
            
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconSH"
        case 1: return "tab2IconSH"
        case 2: return "tab3IconSH"
        default: return ""
        }
    }
    
    private func selectedIcon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconSelectedSH"
        case 1: return "tab2IconSelectedSH"
        case 2: return "tab3IconSelectedSH"
        default: return ""
        }
    }
    
    private func text(for index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Expenses"
        case 2: return "Statistics"
        default: return ""
        }
    }
}

#Preview {
    SHMenuContainerView()
}
