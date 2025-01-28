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
                    if let indexOfFavorite = dataModel.items.firstIndex(where: { $0.id == item.id }) {
                        if dataModel.items[indexOfFavorite].isFavorite {
                            GeometryReader { geo in
                                NavigationLink(destination: DetailProductView(item: item, products: objects).environmentObject(dataModel)) {
                                    SelectedFileView(size: geo.size.width, url: item.imageURL)
                                }
                            }
                            .imageGridModifier()
                            .overlay(alignment: .topTrailing) {
                                if favoritesIsEdit {
                                    DeleteItem() {
                                        markImage(at: indexOfFavorite, asFavorite: false)
                                    }
                                }
                            }
                        }
                    }///if let
                }
            }
            .padding(.top, 5)
        }
        .padding(.horizontal, 7)
    }
}
