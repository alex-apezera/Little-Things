//
//  EditText.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 08.12.2023.
//

import SwiftUI

struct EditText: View {
    @Binding var editText: Bool
    @Binding var text: String
    let title: String
    let prompt: String
    
//MARK: - Input new text
    var body: some View {
        VStack {
            Text(title).opacity(0.5)
            TextField(prompt, text: $text)
                .textFieldModifier()
                .onSubmit { withAnimation {editText = false} }
        }
        .padding(10)
        .background(.thinMaterial)
        .cornerRadius(15)
    }
}
