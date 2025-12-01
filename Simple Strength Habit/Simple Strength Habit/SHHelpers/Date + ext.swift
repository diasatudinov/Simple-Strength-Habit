//
//  File.swift
//  Simple Strength Habit
//
//  Created by Dias Atudinov on 01.12.2025.
//


//
//  Date + ext.swift
//  Coin strike car
//
//

import SwiftUI

extension DateFormatter {
    static let shortEnglish: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yyyy"
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
}