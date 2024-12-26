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
            HStack{
                Button {
                    editText = false
                } label: {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(title)
                Spacer()
                Text("")
            }
            TextField(prompt, text: $text)
            .textFieldModifier()
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}
