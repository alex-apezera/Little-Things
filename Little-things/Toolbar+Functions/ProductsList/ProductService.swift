//
//  ProductService.swift
//  Little-things
//
//  Created by Алексей Езерский on 10.01.2025.
//

import SwiftUI
import SwiftData
@available(iOS 17.0, *)
extension ProductsList {
    
    func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addProduct(_ newProduct: Object) {
        withAnimation {modelContext.insert(newProduct)}
        saveContext()
    }
    
    func deleteProducts(for codes: Set<String>) {
        let favorites = objects
        var offsetsToDelete: IndexSet = []
        for (index, element) in favorites.enumerated() {
            if codes.contains(element.id) {
                offsetsToDelete.insert(index)
            }
            deleteProducts(at: offsetsToDelete)
            selection.removeAll()
        }
    }
    
    func deleteProducts(at offsets: IndexSet) {
        var favorites = objects
        for index in offsets {
            withAnimation {
                modelContext.delete(favorites[index])
            }
        }
        favorites.remove(atOffsets: offsets)
    }
    
    func moveProducts(source: IndexSet, destination: Int) {
        var imageObjects = objects
        imageObjects.move(fromOffsets: source, toOffset: destination)
        saveContext()
    }
    
    func deleteProduct(for item: Object) {
        withAnimation {
            modelContext.delete(item)
        }
    }
    
    func deleteAllProducts() {
        let indexes = products.count
        if indexes > 0 {
            for index in 0...(indexes-1) {
                withAnimation {
                    modelContext.delete(products[index])
                }
            }
        }
    }
    
    func addAllProductsFromDataModel() {
        dataModel.items.forEach { item in
            let newProduct = Object(
                name: item.name,
                price: item.price,
                specification: item.specification,
                imageURL: item.imageURL
            )
            addProduct(newProduct)
            print("\n", #function, "ITEM: \(item)")
        }
    }
        
    func addProductFromDataModel(for index: Int) {
        let newProduct = Object(
            name: dataModel.items[index].name,
            price: dataModel.items[index].price,
            specification: dataModel.items[index].specification,
            imageURL: dataModel.items[index].imageURL)
        addProduct(newProduct)
        print("\n", #function, "INDEX: \(index)")
    }
}
