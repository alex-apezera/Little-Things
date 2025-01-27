//
//  ProductsToolbar.swift
//  Little-things
//
//  Created by Алексей Езерский on 17.01.2025.
//

import SwiftUI

@available(iOS 17.0, *)
extension ProductsList {
    
    @ToolbarContentBuilder
    func productsToolbar() -> some ToolbarContent {
  
        ToolbarItemGroup(placement: .topBarTrailing) {
            
//MARK: - Toggle list/grid mode
            ListModeToggle(editMode: $editMode, listMode: $favoritesListMode, isEditing: $favoritesIsEdit)

//MARK: - Sort Product by name/price
            Button {
                sortByName.toggle()
            }label: {
                Image(systemName: sortByName ? "rublesign" : "character")
            }.disabled(objects.isEmpty)
        }
  
//MARK: - Editing Mode
        ToolbarItem(placement: .topBarLeading) {
            productEditButton
        }
        
//MARK: - Bottom State String and add/delete buttons
        ToolbarItemGroup(placement: .bottomBar) {
            
            /// Add
            productAddButton
            
            /// Status
            Spacer()
            ToolbarStatus(title: "фото", lastUpdated: lastUpdatedProduct, count: products.count)
            Spacer()
            
            /// Delete
            if editMode == .active {
                DeleteButton(allObjects: false) {withAnimation{deleteProducts(for: selection)}}
                    .disabled(selection.isEmpty)
            } else {
                DeleteButton(allObjects: true, action: withAnimation{deleteAllProducts})
                    .disabled(products.isEmpty)
            }
        }
    }
}
