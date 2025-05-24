//
//  IsFavoriteToggle.swift
//  Little-things
//
//  Created by Алексей Езерский on 18.01.2025.
//

import SwiftUI

/// `Button` Toggle  isFavorite property and perform closure action
struct IsFavoriteToggle: View {
    @Binding var isFavorite: Bool
    var action: () -> Void = {}
            
    var body: some View {
        Button {
            withAnimation { isFavorite.toggle() }
            action()
        } label: {
            Image(systemName: isFavorite ? "star.circle.fill" : "star.circle")
                .font(Font.title2)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .red)
        }
    }
}
