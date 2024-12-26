//
//  MoveItem.swift
//  Little-things
//
//  Created by Алексей Езерский on 06.01.2025.
//

import SwiftUI

struct MoveItem: View {
    var action: () -> Void = {}
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Image(systemName: "arrowshape.right")
                .font(Font.title2).bold()
                .foregroundStyle(.orange)
        }

    }
}
