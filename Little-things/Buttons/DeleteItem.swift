//
//  DeleteItem.swift
//  Little-things
//
//  Created by Алексей Езерский on 06.01.2025.
//

import SwiftUI

/// Delete action for the item
///
struct DeleteItem: View {
    var action: () -> Void = {}
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(Font.title2)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .red)
        }
    }
}
