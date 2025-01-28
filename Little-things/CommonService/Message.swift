//
//  Message.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 16.03.2025.
//

import SwiftUI

struct Message: View {
    let message: String
    var body: some View {
        Text(message)
            .padding(15)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
            .background(.ultraThinMaterial)
            .shadow(radius: 5)
            .font(.body)
    }
}

