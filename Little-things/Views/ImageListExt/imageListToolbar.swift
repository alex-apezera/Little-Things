//
//  imageListToolbar.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import SwiftUI
import PhotosUI

extension ImageList {
        
//MARK: - Refresh and Show Image Gallery
    
    @ToolbarContentBuilder
    var imageListToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            
            //MARK: - Call ImagesPicker (variants)
            if onlyPhotoSelection {
                NavigationLink { PhotoPicker()
                        .environmentObject(dataModel)
                } label: { Image(systemName: "photo") }
                .disabled(isEditing || editMode == .active) }
            else {
                PhotosPicker(selection: $selectedItems, photoLibrary: .shared()) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Image(systemName: "photo.stack")
                    }
                }
            }
            
            //MARK: - Call capturing photo
            NavigationLink {
                if enableVideo {
                    VideoContentView().environmentObject(dataModel)
                        .id(tabSelected)/// Force refresh content view
                } else {                     CapturedPhotoView().environmentObject(dataModel)
                }
            } label: { Image(systemName: enableVideo ? "video" : "camera") }
                .disabled(isEditing || editMode == .active)
        }

        ToolbarItem(placement: .topBarLeading) {
            
            //MARK: - Editing Mode
            ListModeToggle(editMode: $editMode, listMode: $listMode, isEditing: $isEditing)
        }

        ToolbarItemGroup(placement: .bottomBar) {
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
    }
}

