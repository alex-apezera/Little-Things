//
//  productGridMode.swift
//  Little-things
//
//  Created by Алексей Езерский on 20.01.2025.
//

import SwiftUI

@available(iOS 17.0, *)
extension ProductsList {
    
    var productGridMode: some View {
        
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridColumns) {
                ForEach(objects) { item in
                    GeometryReader { geo in
                        NavigationLink(destination: DetailProductView(item: item, products: objects)) {
                            SelectedImageView(size: geo.size.width, url: item.imageURL)
                        }
                    }
                    .imageGridModifier()
                    .overlay(alignment: .topTrailing) {
                        if favoritesIsEdit {
                            DeleteItem() {deleteProduct(for: item)}
                        }
                    }
                }
            }.padding(.top, 5)
        }.padding(.horizontal, 7)
    }
}
