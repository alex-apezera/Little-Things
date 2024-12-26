//
//  showProducts.swift
//  Little-things
//
//  Created by Алексей Езерский on 20.01.2025.
//

import SwiftUI

@available(iOS 17.0, *)
extension ProductsList {
    
    func showProducts(_ products: [Object]) -> some View {
        ForEach(products) { item in
            GeometryReader { geo in
                NavigationLink(destination: DetailProductView(item: item, products: products)) {
                    SelectedImageView(size: geo.size.width, url: item.imageURL)
                }
            }
            .imageGridModifier()
            .overlay(alignment: .topTrailing) {
                if isEditing {
                    DeleteItem() {deleteProduct(for: item)}
                }
            }
        }
    }
}
