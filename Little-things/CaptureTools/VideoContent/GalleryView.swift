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
    @State var menuSelection: Int = 0
    @State var showDetailView: Bool = false
    @State var showMessage: Bool = false
    @AppStorage("galleryColumns") var galleryColumns = 3
    @State var photosPickerItems: [PhotosPickerItem] = []
    var title: String {
        switch mediaType {
        case .video: "видео"
        case .photo: "фото"
        }
    }

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
            
            if menuSelection == 3 {/// Select  media files to delete from library
                switch mediaType {
                case .video: selectVideosToDelete
                case .photo: selectPhotosToDelete
                }
            }

            ScrollView {/// Present media files
                switch mediaType {
                case .photo: photoGallery
                case .video: videoGallery
                }
            }
        }
        .background(.ultraThinMaterial)
        .sheet(isPresented: $showDetailView) {
            if let fileImageCover { detailContent(with: fileImageCover) }
        }
    }
}
