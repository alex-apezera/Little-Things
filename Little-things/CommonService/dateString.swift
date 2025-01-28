//
//  dateString.swift
//  Little-things
//
//  Created by Алексей Езерский on 10.04.2025.
//

import Foundation

func dateString(for date: Date?) -> String {

    // Create Date
    if let date {
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date/Time Style
        dateFormatter.dateStyle = iPadDevice ? .full : .long
        dateFormatter.timeStyle = .short

        // Set Locale
        dateFormatter.locale = Locale(identifier: "ru_RU")

        // Convert Date to String
        return dateFormatter.string(from: date) // January 23, 2023 at 9:40 PM
    }
    return ""
}
