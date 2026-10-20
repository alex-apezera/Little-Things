//
//  ListMode.swift
//  Little-things
//
//  Created by Алексей Езерский on 25.01.2025.
//

import SwiftUI

/// List/Grid mode toggle action
///
struct ListModeToggle: View {
    @Binding var editMode: EditMode
    @Binding var listMode: Bool
    @Binding var isEditing: Bool
    var body: some View {
        Button {
            withAnimation {
                listMode.toggle()
            }
            isEditing = false
            editMode = .inactive
        } label: {
            Image(systemName: !listMode ? "square.fill.text.grid.1x2" : "square.grid.3x3.fill")
        }
    }
}
