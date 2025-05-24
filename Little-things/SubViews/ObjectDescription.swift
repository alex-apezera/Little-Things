//
//  ObjectDescription.swift
//  Little-things
//
//  Created by Алексей Езерский on 20.01.2025.
//

import SwiftUI

struct ObjectDescription: View {
    @Binding var isPresented: Bool
    @Binding var property: String
    let title: String
    let prompt: String
    let font: Font
    
    var body: some View {
        if isPresented {
            EditText(editText: $isPresented, text: $property, title: title, prompt: prompt)
        }
        HStack {
            Text(title).foregroundStyle(.secondary).fontWeight(.ultraLight)
            Text("  ")
            Text(property)
        }
        .font(font)
        .onTapGesture {
            isPresented = true
        }
    }
}

struct SimpleDescription: View {
    let property: String
    let title: String
    let font: Font
    
    var body: some View {
        HStack {
            Text(title).foregroundStyle(.secondary).fontWeight(.ultraLight)
            Text("  ")
            Text(property)
        }
        .font(font)
    }
}
