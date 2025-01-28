//
//  DetailFileView.swift
//  Little-things
//
//  Created by Алексей Езерский on 11.04.2025.
//

import SwiftUI

struct DetailFileView: View {
    let size: CGFloat
    let url: URL

    var body: some View {
        
        if url.isImage {
            GesturedPhotoView(size: size, url: url)
        } else if url.isVideo {
            MoviePlay(size: size, url: url)
        } else {
            Text("Ошибка: некорректный файл \(url.absoluteString)")
        }
        
    }
}
