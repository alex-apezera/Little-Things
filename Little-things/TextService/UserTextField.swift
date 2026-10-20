//
//  UserTextField.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.08.2024.
//

import SwiftUI

/// Custom TextField with Alert.
///
struct UserTextField: View {
    
    let prompt: String
    @Binding var text: String
    @State var showAlert: Bool = false
    
    var body: some View {
        TextField(prompt, text: $text) {isChanged in
            let incorrectCharacters = notAllowedCharacters(in: text)
            if !isChanged && incorrectCharacters != 0 {
                showAlert = true
            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Некорректны \(notAllowedCharacters(in: text)) символов. Попробуйте повторить ввод \(prompt)."),                 dismissButton: .cancel(Text("Отменить")))
        }
    }
}
