//
//  SelectedFileView.swift
//  Little-things
//
//  Created by Алексей Езерский on 11.04.2025.
//

import SwiftUI
// Display corresponding methods for representation file
struct SelectedFileView: View {
    let size: Double
    let url: URL

    var body: some View {
        
        if url.isImage {
            SelectedImageView(size: size, url: url)
        } else if url.isVideo {
            firstFrame(size, url)
        } else {
            Text("Ошибка: некорректный формат файла \(url.absoluteString)")
        }
    }
}
