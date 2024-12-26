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

//MARK: - Sort Product by name/price
            Button {
                sortByName.toggle()
            }label: {
                Image(systemName: sortByName ? "rublesign" : "character")
            }.disabled(products.isEmpty)
        }
  
//MARK: - Editing Mode
        ToolbarItem(placement: .topBarLeading) {
            Button {
                withAnimation {isEditing.toggle()}
            } label: {
                Image(systemName: isEditing ? "pencil.slash" : "pencil")
                    .foregroundStyle(isEditing ? .orange : .accentColor)
            }
        }
        
//MARK: - Bottom State String and add/delete buttons
        ToolbarItemGroup(placement: .bottomBar) {
/// Add
            Button {withAnimation {addProducts = true}
            } label: {Image(systemName: "arrowshape.right")}
            .actionSheet(isPresented: $addProducts) {
                ActionSheet(
                    title: Text("Добавить фото объектов?"),
                    message: Text("Для удаления всех элементов нажмите на 'Trash'"),
                    buttons:[
                        .destructive(Text("Добавить"), action: addAllProductsFromDataModel),
                        .cancel(Text("Отменить"))
                    ]
                )
            }.disabled(dataModel.items.isEmpty)
/// Status
            Spacer()
            ToolbarStatus(title: "фото", lastUpdated: lastUpdatedProduct, count: products.count)
            Spacer()
/// Delete
            Button {withAnimation {deleteProducts = true}
            } label: {Image(systemName: "trash")}
            .actionSheet(isPresented: $deleteProducts) {
                ActionSheet(
                    title: Text("Удалить все объекты?"),
                    message: Text("Это действие нельзя отменить!"),
                    buttons:[
                        .destructive(Text("Удалить"), action: deleteAllProducts),
                        .cancel(Text("Отменить"))
                    ]
                )
            }.disabled(products.isEmpty)
        }
    }
}
