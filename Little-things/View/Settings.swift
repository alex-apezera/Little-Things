//
//  Settings.swift
//  Little-things
//
//  Created by Алексей Езерский on 05.01.2025.
//

import SwiftUI

struct Settings: View {
    let title: String
    @AppStorage("saveToPhotoLibrary") var saveToPhotoLibrary = false
    
    var body: some View {
        List {
            Section(header: Text("Сохранение снимаемых фото").fontWeight(.bold).font(.uppercaseSmallCaps(.body)())) {
                
                Toggle("В фотобиблиотеку", isOn: $saveToPhotoLibrary)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
