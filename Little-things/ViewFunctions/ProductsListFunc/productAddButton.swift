//
//  productAddButton.swift
//  Little-things
//
//  Created by Алексей Езерский on 27.01.2025.
//

import SwiftUI

@available(iOS 17.0, *)
extension ProductsList {
    
    var productAddButton: some View {
        
        Button {
            withAnimation {addFavorites = true}
        } label: {
            Image(systemName: "square.and.arrow.down")
        }
        .actionSheet(isPresented: $addFavorites) {
            ActionSheet(
                title: Text("Добавить все объекты в Избранное?"),
                message: Text("Для удаления всех объектов нажмите на 'Корзину'"),
                buttons:[
                    .destructive(Text("Добавить"), action: markAllProductsAsFavorite),
                    .cancel(Text("Отменить"))
                ]
            )
        }
        .disabled(dataModel.items.isEmpty)
    }
}

