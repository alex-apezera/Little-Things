//
//  SimpleDescription.swift
//  Little-things
//
//  Created by Алексей Езерский on 21.10.2026.
//

import SwiftUI

/// Call the object description
///
struct SimpleDescription: View {
    let property: String
    let title: String
    let font: Font
    
    var body: some View {
        HStack {
            Text(title).foregroundStyle(.secondary).fontWeight(.ultraLight)
            Text(property)
        }
        .font(font)
    }
}

