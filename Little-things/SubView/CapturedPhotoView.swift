//
//  CapturedPhotoView.swift
//  Little-things
//
//  Created by Алексей Езерский on 29.12.2024.
//

import SwiftUI

struct CapturedPhotoView: View {
    @EnvironmentObject private var dataModel: DataModel
    @State private var showCameraPicker = false
    @State private var image: Image?
    @AppStorage("saveToPhotoLibrary") var saveToPhotoLibrary = false
    var title: String {
        if image != nil {
           return "Снятое фото"
        } else {
            return "Снять фото"
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Button {
                showCameraPicker = true
            } label: {
                if let image {
                    image.resizable()
                } else {
                    Image(systemName: "camera").font(.title)
                }
            }
            .fullScreenCover(isPresented: $showCameraPicker) {
                CameraPicker() { uiimage in
                    let id = randomString(length: idLength)
                    if let fileURL = FileManager.default.createFileInDirectory(name: id) {
                        let item = Item(id: id, name: id, price: "0.00", specification: "", imageURL: fileURL)
                        if let data = uiimage.jpegData(compressionQuality: 1.0) {
                            try? data.write(to: fileURL)
                            dataModel.addItem(item)
                            storeDataObject(dataModel.items)
                        }
                    }
                    image = Image(uiImage: uiimage)
                    if saveToPhotoLibrary {
                        let imageSaver = ImageSaver()
                        imageSaver.writeToPhotoAlbum(image: uiimage)
                    }
                }
            } 
        }
        .padding()
        .scaledToFit()
        .cornerRadius(10)
        .shadow(radius: 10)
        .navigationModifier(title)
    }
}
