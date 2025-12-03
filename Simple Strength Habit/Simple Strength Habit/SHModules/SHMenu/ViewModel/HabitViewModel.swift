//
//  HabitViewModel.swift
//  Simple Strength Habit
//
//

import SwiftUI

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = [
    ]
    {
        didSet {
            saveHabits()
        }
    }
    
    private var myCarsfileURL: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("habits.json")
    }
    
    // MARK: – Init
    init() {
        loadHabits()
    }
    
    // MARK: – Save / Load MY CARS
    
    private func saveHabits() {
        let url = myCarsfileURL
        do {
            let data = try JSONEncoder().encode(habits)
            try data.write(to: url, options: [.atomic])
        } catch {
            print("Failed to save myDives:", error)
        }
    }
    
    private func loadHabits() {
        let url = myCarsfileURL
        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let habits = try JSONDecoder().decode([Habit].self, from: data)
            self.habits = habits
        } catch {
            print("Failed to load myDives:", error)
        }
    }
    
    // MARK: - Public functions
    
    func add(habit: Habit) {
        guard !habits.contains(habit) else { return }
        habits.append(habit)
        
    }
    
    func delete(habit: Habit) {
        guard let index = habits.firstIndex(of: habit) else { return }
        habits.remove(at: index)
    }
    
    func edit(habit: Habit, habitName: HabitName, habitGoal: Decimal, habitType: HabitType) {
        guard let index = habits.firstIndex(of: habit) else { return }
        habits[index].name = habitName
        habits[index].goal = habitGoal
        habits[index].type = habitType
    }
    
    func toggleHabitComplete(habit: Habit) {
        guard let index = habits.firstIndex(of: habit) else { return }
        habits[index].isCompleted.toggle()
        
        if habits[index].isCompleted {
            habits[index].progress = habits[index].goal
        }
    }
    
    func editProgress(habit: Habit, progress: Decimal) {
        guard let index = habits.firstIndex(of: habit) else { return }
        habits[index].progress = progress
        
        if habits[index].progress == habits[index].goal {
            habits[index].isCompleted = true
        } else {
            habits[index].isCompleted = false
        }
    }
}
