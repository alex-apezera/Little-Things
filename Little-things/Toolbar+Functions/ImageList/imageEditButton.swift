//
//  imageEditButton.swift
//  Little-things
//
//  Created by Алексей Езерский on 27.01.2025.
//

import SwiftUI
extension ImageList {
    
    var imageEditButton: some View {
        Button {
            withAnimation {
                if listMode {
                    if editMode == .active {
                        editMode = .inactive
                    } else {
                        editMode = .active
                    }
                } else {
                    isEditing.toggle()
                }
            }
        } label: {
            if dataModel.items.isEmpty {
                Image(systemName: "pencil")
                    .onAppear {
                        isEditing = false
                        editMode = .inactive
                    }
            } else {
                let editIsActive = isEditing || editMode == .active
                Image(systemName: editIsActive ? "pencil.slash" : "pencil")
                    .foregroundStyle(editIsActive ? .orange : .accentColor)
            }
        }
        .disabled(dataModel.items.isEmpty)
    }
}
