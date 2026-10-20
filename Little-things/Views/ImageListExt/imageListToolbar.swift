//
//  imageListToolbar.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import SwiftUI
import PhotosUI

extension ImageList {
        
    /// Toolbar for refresh and show the media files in current gallery
    ///
    @ToolbarContentBuilder
    var imageListToolbar: some ToolbarContent {
        
        ToolbarItem(placement: .topBarLeading) {
            ListModeToggle(editMode: $editMode, listMode: $listMode, isEditing: $isEditing)
        }

        ToolbarItemGroup(placement: .topBarTrailing) {
            if onlyPhotoSelection {
                NavigationLink {
                    Text("Выбрать фото (без данных)")
                    PhotoPicker()
                    .environmentObject(dataModel)
                } label: { Image(systemName: "plus.square") }
                .disabled(isEditing || editMode == .active) }
            else {
                PhotosPicker(selection: $selectedItems, photoLibrary: .shared()) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Image(systemName: "plus.square.on.square")
                    }
                }
            }
            
            /// Call capturing photo or video (inactive for Mac)
            /// Mini gallery is active then the video is enable in the Settings
            ///
            NavigationLink {
                if enableVideo {
                    VideoContentView().environmentObject(dataModel)
                        .id(tabSelected)/// Force refresh content view
                } else {
                    CapturedPhotoView().environmentObject(dataModel)
                }
            } label: {
                Image(systemName: enableVideo ? "video" : "camera")
            }
            .disabled(isEditing || editMode == .active)
            .disabled(isMacDesignedForIPad)
        }

    }
    
    /// Status bar of the current gallery
    ///
    var galleryStatus: some View {
        
        HStack {
            imageEditButton
            
            Spacer()
            ToolbarStatus(title: "всего объектов: ", lastUpdated: lastUpdatedObject, count: dataModel.items.count)
            Spacer()
            
            if editMode == .active {
                DeleteButton(allObjects: false) { withAnimation{deleteImageObjects(for: selection)}}
                    .disabled(selection.isEmpty)
            } else {
                DeleteButton(allObjects: true, action: withAnimation {dataModel.removeAllItems})
                    .disabled(dataModel.items.isEmpty)
            }
        }
        .padding(.horizontal, 20)
    }
}

