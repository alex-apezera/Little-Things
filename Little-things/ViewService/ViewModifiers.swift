//
//  ViewModifiers.swift
//  Little-things
//
//  Created by Алексей Езерский on 06.01.2025.
//

import SwiftUI

//MARK: - Navigation bar modifier

struct NavigationModifier: ViewModifier {
    let title: String
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .buttonStyle(.borderless)
    }
}

//MARK: - Image cell & grid

struct ImageCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}
struct ImageGridModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(8.0)
            .shadow(radius: 3)
            .aspectRatio(1, contentMode: .fit)
    }
}

//MARK: - TextField

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .foregroundColor(.accentColor)
            .keyboardType(.emailAddress)
            .background(.ultraThinMaterial)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.orange, lineWidth: 1.2))
    }
}
