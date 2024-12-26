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
    
    func addProduct(_ newProduct: Object) {
        withAnimation {modelContext.insert(newProduct)}
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteProduct(offsets: IndexSet) {
        for index in offsets {
            withAnimation {
                modelContext.delete(products[index])
            }
        }
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
