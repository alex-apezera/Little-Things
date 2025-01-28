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
    var productsToolbar: some ToolbarContent {
  
        ToolbarItemGroup(placement: .topBarTrailing) {
            productAddButton
            productSortButton
        }
        
        ToolbarItem(placement: .principal) {
            sortedMessage ///by name or price
        }
        
        ToolbarItem(placement: .topBarLeading) {
            ListModeToggle(editMode: $editMode, listMode: $favoritesListMode, isEditing: $favoritesIsEdit)
        }
                
        ToolbarItemGroup(placement: .bottomBar) {
            HStack {
                productEditButton
                Spacer()
                ToolbarStatus(title: "всего объектов: ", lastUpdated: lastUpdatedProduct, count: productsCounter)
                    .onTapGesture {productsCount = productsCounter}
                Spacer()
                VStack {
                    if editMode == .active {
                        DeleteButton(allObjects: false) {withAnimation{deleteProducts(for: selection)}}
                            .disabled(selection.isEmpty)
                    } else {
                        DeleteButton(allObjects: true, action: withAnimation{markAllProductsAsNotFavorite})
                            .disabled(productsCounter == 0)
                    }
                }
            }
        }
    }
}
