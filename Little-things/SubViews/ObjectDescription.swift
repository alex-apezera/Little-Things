//
//  ObjectDescription.swift
//  Little-things
//
//  Created by Алексей Езерский on 20.01.2025.
//

import SwiftUI

/// Call editing the object description
///
struct ObjectDescription: View {
    @Binding var useEditor: Bool
    @Binding var property: String
    let title: String
    let prompt: String
    let font: Font
    
    var body: some View {
        if useEditor {
            EditText(editText: $useEditor, text: $property, title: title, prompt: prompt)
        } else {
            SimpleDescription(property: property, title: title, font: font)
                .onTapGesture { useEditor = true }
        }
    }
}
