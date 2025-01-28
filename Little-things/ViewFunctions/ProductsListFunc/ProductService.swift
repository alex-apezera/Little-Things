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
        let favorites = /* objects */ dataModel.items
        var offsetsToDelete: IndexSet = []
        for (index, element) in favorites.enumerated() {
            if codes.contains(element.id) {
                offsetsToDelete.insert(index)
            }
            deleteProducts(at: offsetsToDelete)
        }
        selection.removeAll()
    }
    
    func deleteProducts(at offsets: IndexSet) {
//        var favorites = objects
        for index in offsets {
            withAnimation {
                dataModel.items[index].isFavorite = false
//                modelContext.delete(favorites[index])
            }
        }
        storeDataObject(dataModel.items)
        productsCount = productsCounter
        lastUpdatedProduct = Date().timeIntervalSince1970

//        favorites.remove(atOffsets: offsets)
//        saveContext()
    }
    
    func moveProducts(source: IndexSet, destination: Int) {
        var imageObjects = objects
        imageObjects.move(fromOffsets: source, toOffset: destination)
        saveContext()
    }
    
    func markImage(at index: Int, asFavorite: Bool) {
        dataModel.items[index].isFavorite = asFavorite
        storeDataObject(dataModel.items)
        productsCount = productsCounter
        lastUpdatedProduct = Date().timeIntervalSince1970
    }

    func markAllProductsAsNotFavorite() {
        markAllImages(asFavorite: false)
    }
    
    func markAllProductsAsFavorite() {
        markAllImages(asFavorite: true)
    }
    
    func markAllImages(asFavorite: Bool) {
        let indexes = dataModel.items.count
        if indexes > 0 {
            for index in 0...(indexes-1) {
                dataModel.items[index].isFavorite = asFavorite
            }
        }
        storeDataObject(dataModel.items)
        productsCount = productsCounter
        lastUpdatedProduct = Date().timeIntervalSince1970
    }
        
    var productsCounter: Int {
        var counter = 0
        dataModel.items.forEach { item in
            if item.isFavorite {
                counter += 1
            }
        }
        return counter
    }

    var restoreProductsFromDataModel: Void {
        deleteAllProducts()
        addAllProductsFromDataModel()
    }

    func deleteAllProducts() {
        let indexes = products.count
        if indexes > 0 {
            for index in 0...(indexes-1) {
                withAnimation {
                    modelContext.delete(objects[index])
                }
            }
        }
        saveContext()
    }
    
    func addAllProductsFromDataModel() {
        dataModel.items.forEach { item in
            let newProduct = Object(
                id: item.id,
                name: item.name,
                price: item.price,
                specification: item.specification,
                imageURL: item.imageURL
            )
            addProduct(newProduct)
//            print("\n", #function, "ITEM: \(item)")
        }
    }
}

/* // delete/add product in modelContext
 func deleteProduct(for item: Object) {
     withAnimation {
         modelContext.delete(item)
     }
     saveContext()
 }
 
 func addProductFromDataModel(for index: Int) {
        markImage(at: index, asFavorite: true)
        let newProduct = Object(
            id: dataModel.items[index].id,
            name: dataModel.items[index].name,
            price: dataModel.items[index].price,
            specification: dataModel.items[index].specification,
            imageURL: dataModel.items[index].imageURL)
        addProduct(newProduct)
        print("\n", #function, "INDEX: \(index)")
 }
*/
//Alternate, using stackoverflow.com
/*
 func deleteAllProducts() {
     let key = objects[0].id
     let predicate = #Predicate<Object> { object in
             object.id == key
     }
     let indexes = objects.count
     if indexes > 0 {
         for index in 0...(indexes-1) {
             withAnimation {
                 modelContext.delete(objects[index])
             }
         }
     }
     do {
         try modelContext.delete(model: Object.self, where: predicate)
     }
     catch {
         print("Error deleting all products: \(error)")
     }
     saveContext()
 }
 */
