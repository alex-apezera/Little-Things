//
//  UsePhoto.swift
//  Little-things
//
//  Created by Алексей Езерский on 18.04.2025.
//

import SwiftUI
/// Use photo image for store in App gallery
struct UsePhoto {
    @AppStorage("jpegCompression") var jpegCompression: Double  = 1.0
    @ObservedObject var dataModel: DataModel

    func storePhotoToGallery(uiimage: UIImage) {
        
        let id = randomString(length: idLength)
        if let fileURL = FileManager.default.createFileInDirectory(name: id) {
            let item = Item(id: id, name: "Фото", price: dateString(for: Date()), specification: "Нет данных", imageURL: fileURL, isFavorite: false)
            if let data = uiimage.jpegData(compressionQuality: jpegCompression) {
                try? data.write(to: fileURL)
                withAnimation { dataModel.addItem(item) }
                storeDataObject(dataModel.items)
            }
        }
    }
}

