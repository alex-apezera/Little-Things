//
//  GalleryExt.swift
//  Little-things
//
//  Created by Алексей Езерский on 09.04.2025.
//

import SwiftUI
import PhotosUI

extension GalleryView {
    
    /// Auxiliary calculations for minigallery width
    ///
    private struct GalleryWidthKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }

    /// Side value of a thumbnail
    ///
    private func gallerySide(width: CGFloat) -> CGFloat {
        let columnsCount = max(1, galleryColumns)
        return max(1, (width - gallerySpacing * CGFloat(columnsCount - 1)) / CGFloat(columnsCount))
    }

    /// Height of a minigallery
    ///
    private func galleryHeight(width: CGFloat) -> CGFloat {
        let columnsCount = max(1, galleryColumns)
        let side = gallerySide(width: width)
        let rows = ceil(Double(viewModel.photoFiles.count) / Double(columnsCount))
        return CGFloat(rows) * (side + galleryVerticalPadding)
    }

    
    /// Disappearing message
    ///
    private func messageManage() {
        showMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {  withAnimation { showMessage = false } }
    }
    
    /// Thumbnail image of a photo or a first video frame
    ///
    func detailContent(with image: Image, side: CGFloat) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: side, height: side) // Square
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.white, lineWidth: 1)
            )
            .padding(.vertical, galleryVerticalPadding)
    }

    /// Mini gallery of photos with actions
    ///
    @ViewBuilder
    var photoGallery: some View {
        let columnsCount = max(1, galleryColumns)
        let side = gallerySide(width: galleryWidth)

        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: side, maximum: side)), count: columnsCount), spacing: gallerySpacing) {
            ForEach(viewModel.photoFiles) { file in
                detailContent(with: file.image, side: side)
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
        .background(
            GeometryReader { geo in
                Color.clear.preference(key: GalleryWidthKey.self, value: geo.size.width)
            }
        )
        .onPreferenceChange(GalleryWidthKey.self) { galleryWidth = $0 }
        .frame(height: galleryWidth == 0 ? nil : galleryHeight(width: galleryWidth))
        .showMessageInBox("Фото сейчас перемещено в галерею объектов", showMessage)
        .padding(.leading, gallerySpacing)
        .padding(.trailing, gallerySpacing)
        .onAppear {viewModel.fetchPhotoFiles()}
    }
    
    /// Mini gallery of first video frames with actions
    ///
    @ViewBuilder
    var videoGallery: some View {
        let columnsCount = max(1, galleryColumns)
        let side = gallerySide(width: galleryWidth)

        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: side, maximum: side)), count: columnsCount), spacing: gallerySpacing) {
            ForEach(viewModel.videoFiles) { file in
                detailContent(with: file.thumbnailImage, side: side)
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
        .background(
            GeometryReader { geo in
                Color.clear.preference(key: GalleryWidthKey.self, value: geo.size.width)
            }
        )
        .onPreferenceChange(GalleryWidthKey.self) { galleryWidth = $0 }
        .frame(height: galleryWidth == 0 ? nil : galleryHeight(width: galleryWidth))
        .showMessageInBox("Видео уже в галерее объектов", showMessage)
        .padding(.leading, gallerySpacing)
        .padding(.trailing, gallerySpacing)
        .onAppear {viewModel.fetchVideoFiles()}
    }
    
    /// Delete action for the thumbnail
    ///
    func selectObjectsToDelete(_ message: String, _ type: PHPickerFilter) -> some View {
        PhotosPicker(message, selection: $photosPickerItems, matching: type, photoLibrary: .shared())
            .onChange(of: photosPickerItems) { _, items in
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
