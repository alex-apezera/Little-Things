//
//  DeleteItem.swift
//  Little-things
//
//  Created by Алексей Езерский on 06.01.2025.
//

import SwiftUI

//MARK: - Delete item
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
