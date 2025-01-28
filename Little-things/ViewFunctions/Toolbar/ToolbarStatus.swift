//
//  ToolbarStatus.swift
//  Little-things
//
//  Created by Алексей Езерский on 06.01.2025.
//

import SwiftUI

//MARK: - Status of list items
///Contains two strings which shows relative updating time and count of objects in a list.
///
/// - Note: Is recomended to use in toolbar.
struct ToolbarStatus: View {
    var title: String
    var lastUpdated: TimeInterval
    var count: Int
    let locale = "ru_RU"

    var body: some View {
        VStack {
            let lastUpdatedDate = Date(timeIntervalSince1970: lastUpdated)
            Text("Обновлено \(lastUpdatedDate.formatted(.relative(presentation: .named).locale(Locale(identifier: locale))))")
            Text("\(title)\(count)")
                .foregroundStyle(Color.secondary)
        }
        .font(.caption)
    }
}
