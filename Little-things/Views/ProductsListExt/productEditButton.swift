//
//  productEditButton.swift
//  Little-things
//
//  Created by Алексей Езерский on 27.01.2025.
//

import SwiftUI

@available(iOS 17.0, *)
extension ProductsList {
    
    var productEditButton: some View {
        
        Button {
            withAnimation {
                if favoritesListMode {
                    if editMode == .active {
                        editMode = .inactive
                    } else {
                        editMode = .active
                    }
                } else {
                    favoritesIsEdit.toggle()
                }
            }
        } label: {
            if productsCounter == 0 {
                Image(systemName: "pencil")
                    .onAppear {
                        favoritesIsEdit = false
                        editMode = .inactive
                    }
            } else {
                let editIsActive = favoritesIsEdit || editMode == .active
                Image(systemName: editIsActive ? "pencil.slash" : "pencil")
                    .foregroundStyle(editIsActive ? .orange : .accentColor)
            }
        }
        .disabled(productsCounter == 0)
    }
}

