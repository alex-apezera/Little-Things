//
//  productListMode.swift
//  Little-things
//
//  Created by Алексей Езерский on 27.01.2025.
//

import SwiftUI

@available(iOS 17.0, *)
extension ProductsList {
    
    var productListMode: some View {
        
        List(selection: $selection) {
            ForEach(objects) { item in
                if let indexOfFavorite = dataModel.items.firstIndex(where: { $0.id == item.id }) {
                    if dataModel.items[indexOfFavorite].isFavorite {
                        
                        HStack{
                            NavigationLink(destination: DetailProductView(item: item, products: objects).environmentObject(dataModel)) {
                                SelectedFileView(size: 85, url: item.imageURL)
                                    .imageGridModifier()
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name).bold()
                                    Text(item.price)
                                    Text(item.specification).foregroundStyle(.secondary)
                                }
                                .font(.system(size: 12))
                                .lineLimit(3)
                                .frame(height: 90)
                            }
                        }
                    }
                }
            }
//            .onDelete(perform: deleteProducts)
//            .onMove(perform: moveProducts)
        }
    }
}

