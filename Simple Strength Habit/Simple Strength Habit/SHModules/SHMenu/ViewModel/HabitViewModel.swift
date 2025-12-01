//
//  HabitViewModel.swift
//  Simple Strength Habit
//
//

import SwiftUI

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = [
        Habit(name: .waterIntake, goal: 2.5, progress: 0, type: .quantitative),
        Habit(name: .flexibility, goal: 20, progress: 0, type: .quantitative),
        Habit(name: .pushUps, goal: 50, progress: 0, type: .quantitative),
        Habit(name: .running, goal: 30, progress: 0, type: .quantitative),
        Habit(name: .walking, goal: 45, progress: 0, type: .quantitative),
        Habit(name: .sleep, goal: 7, progress: 0, type: .quantitative),
        Habit(name: .healthRecording, goal: 10, progress: 0, type: .quantitative),
    ]
//    {
//        didSet {
//            saveHabits()
//        }
//    }
    
    private var myCarsfileURL: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent("habits.json")
    }
    
    // MARK: – Init
    init() {
      //  loadHabits()
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
}
