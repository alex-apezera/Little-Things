//
//  ItemToolbar.swift
//  Little-things
//
//  Created by Алексей Езерский on 21.10.2026.
//

import SwiftUI

/// Export button.
///
/// Export objects from this App.
struct ItemToolbar: View {

    let item: Item
    @State private var showShareSheet = false

    var body: some View {

        Button {
            showShareSheet = true
        } label: {
            Image(systemName: "square.and.arrow.up")
                .accessibilityLabel("Экспортировать")
        }
        .sheet(isPresented: $showShareSheet) {
            ActivityView(activityItems: item.makeImportProviders())
                .presentationDetents([.medium, .large])
        }
    }
}
