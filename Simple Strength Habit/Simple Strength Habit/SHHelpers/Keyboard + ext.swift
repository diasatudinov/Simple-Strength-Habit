//
//  Keyboard + ext.swift
//  Simple Strength Habit
//


import UIKit
import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}

extension View {
    /// Скрывает клавиатуру при тапе по вью
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.hideKeyboard()
        }
    }
}
