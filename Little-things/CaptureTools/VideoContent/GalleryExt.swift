//
//  GalleryExt.swift
//  Little-things
//
//  Created by Алексей Езерский on 09.04.2025.
//

import Aespa
import SwiftUI
import PhotosUI

extension GalleryView {
    
    private func messageManage() {
        showMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {  withAnimation { showMessage = false } }
    }
    
    func detailContent(with image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .clipped()
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.thickMaterial, lineWidth: 1)
            )
            .padding(.vertical, 2)
    }

    var photoGallery: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 100, maximum: 200)), count: galleryColumns), spacing: 2) {
            ForEach(viewModel.photoFiles) { file in
                detailContent(with: file.image)
                    .onTapGesture {
                        if menuSelection == 1 {
                            fileImageCover = file.image
                            withAnimation { showDetailView = true }
                        } else if menuSelection == 2 {
                            UsePhoto(dataModel: dataModel).storePhotoToGallery(uiimage: file.uiimage)
                            messageManage()
                        }
                    }
            }
        }
        .showMessageInBox("Фото сейчас перемещено в галерею объектов", showMessage)
        .padding(.leading, 5)
        .padding(.trailing, 5)
        .onAppear {viewModel.fetchPhotoFiles()}
    }
    
    var videoGallery: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 100, maximum: 200)), count: galleryColumns), spacing: 2) {
            ForEach(viewModel.videoFiles) { file in
                detailContent(with: file.thumbnailImage)
                    .onTapGesture {
                        if menuSelection == 1 {
                            fileImageCover = file.thumbnailImage
                            withAnimation { showDetailView = true }
                        } else if menuSelection == 2 {
                        messageManage()
                        }
                            
                    }
            }
        }
        .showMessageInBox("Видео перемещаюся в галерею объектов в момент записи", showMessage)
        .padding(.leading, 5)
        .padding(.trailing, 5)
        .onAppear {viewModel.fetchVideoFiles()}
    }
    
    func selectObjectsToDelete(_ message: String, _ type: PHPickerFilter) -> some View {
        PhotosPicker(message, selection: $photosPickerItems, matching: type, photoLibrary: .shared())
            .onChange(of: photosPickerItems) { items in
                items.forEach {item in
                    ImageManager().deleteItemFromLibrary(assetIdentifier: item.itemIdentifier!)
                }
            }
    }

}

//Snipet:
/*
 DispatchQueue.main.async {
     UIApplication.shared.sendAction(#selector(UIResponder.resolveClassMethod), to: nil, from: nil, for: nil)
}
 */
