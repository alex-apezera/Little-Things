//
//  ListMode.swift
//  Little-things
//
//  Created by Алексей Езерский on 25.01.2025.
//

import SwiftUI

//MARK: - List/Grid mode toggle
struct ListModeToggle: View {
    @AppStorage("listMode") var listMode: Bool = false
    var body: some View {
        Button {
            withAnimation {
                listMode.toggle()
            }
        } label: {
            Image(systemName: !listMode ? "square.fill.text.grid.1x2" : "square.grid.3x2")
        }
    }
}
