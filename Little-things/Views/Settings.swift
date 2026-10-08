//
//  Settings.swift
//  Little-things
//
//  Created by Алексей Езерский on 05.01.2025.
//

import SwiftUI

struct Settings: View {
    let title: String
    @AppStorage("onlyPhotoSelection") var onlyPhotoSelection = true
    @AppStorage("saveToPhotoLibrary") var saveToPhotoLibrary = false
    @AppStorage("initialColumns") var initialColumns = 3
    @AppStorage("galleryColumns") var galleryColumns = 3
    @AppStorage("initialColumnsFavorite") var initialColumnsFavorite = 3
    @AppStorage("enableVideo") var enableVideo = false
    @AppStorage("jpegCompression") var jpegCompression: Double  = 1.0
    let compressionQualities: [Double] = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
    
    var body: some View {
        List {
            Section(header: Text("Режим выбора медиафайлов")) {
                Toggle("Только фото без данных", isOn: $onlyPhotoSelection)
            }
            Section(header: Text("Режим съёмки видео")) {
                Toggle(enableVideo ? "Включен":"Выключен", isOn: $enableVideo)
            }
            Section(header: Text("Сохранение результатов съёмки")) {
                Toggle("В фотобиблиотеку", isOn: $saveToPhotoLibrary)
                    .onAppear {
                        if enableVideo { saveToPhotoLibrary = true }
                        else { saveToPhotoLibrary = false}
                    }
                    .disabled(enableVideo)
                Picker(selection: $jpegCompression, label: Text("Степень сжатия JPEG")) {
                    ForEach(compressionQualities, id: \.self) { number in
                        Text(String(number))
                    }
                }
            }
            .onChange(of: enableVideo) { _, newValue in
                if newValue { saveToPhotoLibrary = true }
                else { saveToPhotoLibrary = false}
            }
            Section(header: Text("Количество столбцов в сетке").font(.uppercaseSmallCaps(.body)())) {
                Stepper("Галерея: \(initialColumns)") {
                    initialColumns += 1
                } onDecrement: {
                    initialColumns -= 1
                }
                Stepper("Избранные: \(initialColumnsFavorite)") {
                    initialColumnsFavorite += 1
                } onDecrement: {
                    initialColumnsFavorite -= 1
                }
                Stepper("Съёмка: \(galleryColumns)") {
                    galleryColumns += 1
                } onDecrement: {
                    galleryColumns -= 1
                }
            }
        }
        .font(.uppercaseSmallCaps(.body)())
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
