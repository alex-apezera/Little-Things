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
            Button {
                withAnimation {
                    if listMode {
                        if editMode == .active {
//                            action()
                            editMode = .inactive
                        } else {
                            editMode = .active
                        }
                    } else {
                        isEditing.toggle()
                    }
                }
            } label: {
                Image(systemName: isEditing || editMode == .active ? "pencil.slash" : "pencil")
                    .foregroundStyle(isEditing || editMode == .active ? .orange : .accentColor)
            }
            .disabled(dataModel.items.isEmpty)
        }
//MARK: - Bottom State String
        ToolbarItemGroup(placement: .bottomBar) {
            ListModeToggle()
//            RefreshButton().environmentObject(dataModel)
            Spacer()
            ToolbarStatus(title: "фото", lastUpdated: lastUpdatedObject, count: dataModel.items.count)
            Spacer()
            if editMode == .active {
                DeleteButton(allObjects: false) {deleteImageObjects(for: selection)}
                .disabled(selection.isEmpty)
            } else {
                DeleteButton(allObjects: true, action: dataModel.removeAllItems)
            }
        }
    }
}

