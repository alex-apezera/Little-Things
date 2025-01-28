//
//  ViewExt.swift
//  Little-things
//
//  Created by Алексей Езерский on 06.01.2025.
//

import SwiftUI

//MARK: - View + Modifiers

extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func textFieldModifier() -> some View {
        modifier(TextFieldModifier())
    }
    func imageCellModifier() -> some View {
        modifier(ImageCellModifier())
    }
    func imageGridModifier() -> some View {
        modifier(ImageGridModifier())
    }
    func navigationModifier(_ title: String) -> some View {
        modifier(NavigationModifier(title: title))
    }
    func showMessageInBox(_ message: String, _ showMessage: Bool) -> some View {
        modifier(ShowMessage(message: message, showMessage: showMessage))
    }
    var cameraOff: some View {
        modifier(CameraOff())
    }
}
