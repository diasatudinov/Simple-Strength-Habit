//
//  Habit.swift
//  Simple Strength Habit
//
//

import Foundation

struct Habit: Codable, Hashable, Identifiable {
    var id = UUID()
    var name: HabitName
    var goal: Decimal
    var progress: Decimal
    var type: HabitType
    var isCompleted: Bool = false
}

enum HabitName: Codable, Hashable, CaseIterable {
    case waterIntake
    case proteinIntake
    case pushUps
    case running
    case squats
    case plank
    case pullUps
    case walking
    case stretching
    case meditation
    case sleep
    case flexibility
    case exerciseBike
    case absCrunches
    case jumpingRope
    case vegetableIntake
    case coldShowers
    case strengthTraining
    case morningExercises
    case healthRecording
    
    var text: String {
        switch self {
        case .waterIntake:
            "Water Intake"
        case .proteinIntake:
            "Protein Intake"
        case .pushUps:
            "Push-Ups"
        case .running:
            "Running"
        case .squats:
            "Squats"
        case .plank:
            "Plank"
        case .pullUps:
            "Pull-Ups"
        case .walking:
            "Walking"
        case .stretching:
            "Stretching"
        case .meditation:
            "Meditation"
        case .sleep:
            "Sleep"
        case .flexibility:
            "Flexibility (Yoga/Pilates)"
        case .exerciseBike:
            "Exercise Bike"
        case .absCrunches:
            "Abs (Crunches)"
        case .jumpingRope:
            "Jumping Rope"
        case .vegetableIntake:
            "Vegetable Intake"
        case .coldShowers:
            "Cold Showers"
        case .strengthTraining:
            "Strength Training"
        case .morningExercises:
            "Morning Exercises"
        case .healthRecording:
            "Health Recording"
        }
    }
    
    var unitOfMeasurement: UnitOfMeasurement {
        switch self {
        case .waterIntake:
                .liters
        case .proteinIntake:
                .grams
        case .pushUps:
                .repetitions
        case .running:
                .minutes
        case .squats:
                .pieces
        case .plank:
                .seconds
        case .pullUps:
                .repetitions
        case .walking:
                .minutes
        case .stretching:
                .minutes
        case .meditation:
                .minutes
        case .sleep:
                .hours
        case .flexibility:
                .minutes
        case .exerciseBike:
                .minutes
        case .absCrunches:
                .repetitions
        case .jumpingRope:
                .minutes
        case .vegetableIntake:
                .portions
        case .coldShowers:
                .minutes
        case .strengthTraining:
                .minutes
        case .morningExercises:
                .minutes
        case .healthRecording:
                .points
        }
    }
}

enum UnitOfMeasurement: Codable, Hashable, CaseIterable {
    case liters
    case points
    case grams
    case minutes
    case repetitions
    case portions
    case seconds
    case hours
    case pieces
    
    var text: String {
        switch self {
        case .liters:
            "Liters"
        case .points:
            "Points"
        case .grams:
            "Grams"
        case .minutes:
            "Minutes"
        case .repetitions:
            "Repetitions"
        case .portions:
            "Portions"
        case .seconds:
            "Seconds"
        case .hours:
            "Hours"
        case .pieces:
            "Pieces"
        }
    }
    
    var shortText: String {
        switch self {
        case .liters:
            "L"
        case .points:
            "Points"
        case .grams:
            "Grams"
        case .minutes:
            "Min"
        case .repetitions:
            "Rep"
        case .portions:
            "Portions"
        case .seconds:
            "Sec"
        case .hours:
            "Hours"
        case .pieces:
            "Pcs"
        }
    }
}

enum HabitType: Codable, Hashable, CaseIterable {
    case quantitative
    case binary
    
    var text: String {
        switch self {
        case .quantitative:
            "Quantitative"
        case .binary:
            "Binary"
        }
    }
}

extension Decimal {
    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }
}
