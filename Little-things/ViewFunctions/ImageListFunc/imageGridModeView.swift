//
//  imageGridModeView.swift
//  Little-things
//
//  Created by Алексей Езерский on 27.01.2025.
//

import SwiftUI

extension ImageList {
    
    var imageGridModeView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridColumns) {
                ForEach(dataModel.items) { item in
                    if let index = dataModel.items.firstIndex(of: item) {
                        GeometryReader { geo in
                            NavigationLink(destination: DetailImageView(item: item).environmentObject(dataModel)) {
                                SelectedFileView(size: geo.size.width, url: item.imageURL)
                            }
                        }
                        .imageGridModifier()
                        .overlay(alignment: .topTrailing) {
                            if isEditing {
                                DeleteItem() {
                                    dataModel.removeItem(item) ///just refreshed
                                }
                            }
                        }
                        .overlay(alignment: .bottomTrailing) {
                            if #available(iOS 17.0, *), isEditing {
                                IsFavoriteToggle(isFavorite: $dataModel.items[index].isFavorite) {
                                    storeDataObject(dataModel.items)
                                    lastUpdatedProduct = Date().timeIntervalSince1970
                                }
                            }
                        }
                    }///if
                }///ForEach
            }.padding(.top, 5)
        }.padding(.horizontal, 7)
    }
}
