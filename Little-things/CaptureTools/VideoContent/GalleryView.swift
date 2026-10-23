//
//  GalleryView.swift
//  Little-things
//
//  Created by Алексей Езерский on 03.04.2025.
//
//  Aespa-iOS
//
//  Created by 이영빈 on 2023/06/12.
//

import Aespa
import SwiftUI
import PhotosUI

/// Mini gallery view (Album thumbnail)
///
struct GalleryView: View {
    @ObservedObject var viewModel: VideoContentViewModel
    @EnvironmentObject var dataModel: DataModel
    
    @Binding var mediaType: AssetType
    
    init(
        mediaType: Binding<AssetType>,
        contentViewModel viewModel: VideoContentViewModel,
    ) {
        self._mediaType = mediaType
        self.viewModel = viewModel
    }
    @AppStorage("jpegCompression") var jpegCompression: Double  = 1.0
    @State var fileImageCover: Image? = Image(systemName: "photo")
    @State var menuSelection: Int = 1
    @State var showDetailView: Bool = false
    @State var showMessage: Bool = false
    @State var photosPickerItems: [PhotosPickerItem] = []
    var title: String {
        switch mediaType {
        case .video: "видео"
        case .photo: "фото"
        }
    }
    
    // Settings for a minigallery geometry
    @AppStorage("galleryColumns") var galleryColumns = 3
    @State var galleryWidth: CGFloat = 0
    let gallerySpacing: CGFloat = 5
    let galleryVerticalPadding: CGFloat = 3


    var body: some View {
        VStack(alignment: .center) {
            Text("Съёмочная \(title)галерея")
                .font(.title3).foregroundStyle(.secondary).bold()
                .padding(.top, 10)
            Picker("Фото", selection: $menuSelection) {/// Manage media files
                Text("Детали").tag(1)
                Text("Сохранить").tag(2)
                Text("Удалить").tag(3)
            }
            .cornerRadius(8)
            .frame(width: 300)
            .padding(.top, 5)
            .pickerStyle(.segmented)
            
            // Select  media files to delete from library
            if menuSelection == 3 {
                switch mediaType {
                case .video: selectObjectsToDelete("Выбрать видео из библиотеки", .videos)
                case .photo: selectObjectsToDelete("Выбрать фото из библиотеки", .images)
                }
            }

            ScrollView {/// Present media files in minigallery
                switch mediaType {
                case .photo: photoGallery
                case .video: videoGallery
                }
            }
        }
        .background(.thinMaterial)
        .sheet(isPresented: $showDetailView) {
            if let fileImageCover {
                switch mediaType {
                case .video:
                    Text("Просмотр видео доступен в Галерее").font(.footnote).padding(5)
                case .photo:
                    Text("Просмотр фото")
                        .font(.footnote).padding(5)
                }
                GesturedImage(image: fileImageCover)
            }
        }
        .id(showDetailView)

    }
}
