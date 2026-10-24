//
//  GalleryExt.swift
//  Little-things
//
//  Created by Алексей Езерский on 09.04.2025.
//

import SwiftUI
import PhotosUI

extension GalleryView {
    
    /// Measures the width and transmits it to the galleries.
    ///
    struct GalleryContainer<Content: View>: View {
        @ViewBuilder var content: (CGFloat) -> Content

        var body: some View {
            GeometryReader { geo in
                ScrollView {
                    content(geo.size.width)
                }
            }
        }
    }
    
    /// Side value of a thumbnail
    ///
    private func gallerySide(containerWidth: CGFloat, columns: Int) -> CGFloat {
        let n = max(1, columns)
        let usable = max(1, containerWidth - gallerySpacing * CGFloat(n - 1))
        return max(1, usable / CGFloat(n))
    }
    
    /// Side value of a thumbnail
    ///
    private func gallerySide(width: CGFloat) -> CGFloat {
        let columnsCount = max(1, galleryColumns)
        return max(1, (width - gallerySpacing * CGFloat(columnsCount - 1)) / CGFloat(columnsCount))
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
    }
    
    /// Mini gallery with actions
    ///
    @ViewBuilder
    func galleryGrid<Item: Identifiable, Cell: View>(
        containerWidth: CGFloat,
        items: [Item],
        @ViewBuilder cell: @escaping (Item, CGFloat) -> Cell
    ) -> some View {
        let columnsCount = max(1, galleryColumns)
        let side = gallerySide(containerWidth: containerWidth, columns: columnsCount)

        LazyVGrid(
            columns: Array(
                repeating: GridItem(.adaptive(minimum: side, maximum: side), spacing: gallerySpacing),
                count: columnsCount
            ),
            spacing: gallerySpacing
        ) {
            ForEach(items) { item in
                cell(item, side)
            }
        }
        .padding(.horizontal, gallerySpacing)
        .padding(.vertical, galleryVerticalPadding/2)
    }

    
    /// Mini gallery of photos with actions
    ///
    func photoGallery(_ width: CGFloat) -> some View {
        galleryGrid(containerWidth: width, items: viewModel.photoFiles) { file, side in
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
        .showMessageInBox("Фото сейчас перемещено в галерею объектов", showMessage)
        .onAppear {viewModel.fetchPhotoFiles()}
    }

    /// Mini gallery of videos with actions
    ///
    func videoGallery(_ width: CGFloat) -> some View {
        galleryGrid(containerWidth: width, items: viewModel.videoFiles) { file, side in
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
        .showMessageInBox("Видео уже в галерее объектов", showMessage)
        .onAppear { viewModel.fetchVideoFiles() }
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
