//
//  ThingsToolbar.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import SwiftUI

extension ImageList {
        
//MARK: - Refresh and Show Image Gallery
    
    @ToolbarContentBuilder
    func thingsToolbar() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            
//MARK: - Call ImagesPicker
            NavigationLink { PhotoPicker()
                    .environmentObject(dataModel)
            } label: { Image(systemName: "photo") }
                .disabled(isEditing || editMode == .active)
            
//MARK: - Call capturing photo
            NavigationLink { CapturedPhotoView()
                    .environmentObject(dataModel)
            } label: { Image(systemName: "camera") }
                .disabled(isEditing || editMode == .active)
        }
//MARK: - Editing Mode
        ToolbarItem(placement: .topBarLeading) {
            imageEditButton
        }
//MARK: - Bottom State String
        ToolbarItemGroup(placement: .bottomBar) {
            ListModeToggle(editMode: $editMode, listMode: $listMode, isEditing: $isEditing)
//            RefreshButton().environmentObject(dataModel)
            Spacer()
            ToolbarStatus(title: "фото", lastUpdated: lastUpdatedObject, count: dataModel.items.count)
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

