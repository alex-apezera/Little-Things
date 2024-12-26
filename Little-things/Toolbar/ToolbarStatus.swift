//
//  ToolbarStatus.swift
//  Little-things
//
//  Created by Алексей Езерский on 06.01.2025.
//

import SwiftUI

//MARK: - Status of list item with localized date-time
struct ToolbarStatus: View {
    var title: String
    var lastUpdated: TimeInterval
    var count: Int
    let locale = "ru_RU"

    var body: some View {
        VStack {
            let lastUpdatedDate = Date(timeIntervalSince1970: lastUpdated)
            Text("Обновлено \(lastUpdatedDate.formatted(.relative(presentation: .named).locale(Locale(identifier: locale))))")
            Text("\(count) \(title)")
                .foregroundStyle(Color.secondary)
        }
        .font(.caption)
    }
}
