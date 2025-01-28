//
//  CapturedPhotoView.swift
//  Little-things
//
//  Created by Алексей Езерский on 29.12.2024.
//

import SwiftUI

struct CapturedPhotoView: View {
    @EnvironmentObject private var dataModel: DataModel
    @State private var image: Image?
    @AppStorage("saveToPhotoLibrary") var saveToPhotoLibrary = false
    @AppStorage("jpegCompression") var jpegCompression: Double  = 1.0

    var title: String {
        if image != nil {return "Снятое фото"}
        else {return "Снять фото"}
    }
    
    var body: some View {
        NavigationLink {
            CapturePhoto() { uiimage in
                UsePhoto(dataModel: dataModel).storePhotoToGallery(uiimage: uiimage)
                image = Image(uiImage: uiimage)
                if saveToPhotoLibrary {
                    let imageSaver = ImageManager()
                    imageSaver.writeToPhotoAlbum(image: uiimage)
                }
            }
        } label: {
            if let image {
                image.resizable()
            } else {
                Image(systemName: "camera").font(.title)
            }
        }
        .padding()
        .scaledToFit()
        .cornerRadius(10)
        .shadow(radius: 10)
        .navigationModifier(title)
    }
}
