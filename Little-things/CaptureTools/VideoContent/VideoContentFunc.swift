//
//  VideoContentFunc.swift
//  Little-things
//
//  Created by Алексей Езерский on 21.04.2025.
//

import Foundation
import Aespa
import SwiftUICore
extension VideoContentView {
    
    /// Stores video file in `ImageList` Gallery
    func storeVideoToGallery(file: VideoFile) {
        let id = randomString(length: idLength)
        if let savedUrl = FileManager.default.copyItemToDocumentDirectory(from: file.path ?? URL(fileURLWithPath: ""), to: id) {
            /// Add the new item to the data model.
            Task { @MainActor in
                withAnimation(.spring(duration: 0.6, bounce: 0.4)) {
                    let item = Item(id: id, name: "Видео", price: dateString(for: Date()), specification: "Не задано", imageURL: savedUrl, isFavorite: false)
                    dataModel.addItem(item)
                    storeDataObject(dataModel.items)
                    print("\n", "SAVED ITEM: ", item)
                }
            }
        }
    }
    
    /// Shows cell as `Button` with photo or first frame of video
    @ViewBuilder
    func roundRectangleShape(with image: Image, size: CGFloat) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size, alignment: .center)
            .clipped()
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 1)
            )
            .padding(20)
    }
    
    /// Use `Button` for recording video or capture photo
    @ViewBuilder
    func recordingButtonShape(width: CGFloat) -> some View {
        ZStack {
            Circle()
                .strokeBorder(isRecording ? .red : .white, lineWidth: 3)
                .frame(width: width)
            
            Circle()
                .fill(isRecording ? .red : .white)
                .frame(width: width * 0.8)
        }
        .frame(height: width)
    }
}
