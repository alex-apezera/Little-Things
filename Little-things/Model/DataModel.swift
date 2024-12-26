//
//  DataModel.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import Foundation

final class DataModel: ObservableObject {
    @Published var items: [Item] = []
    
        init() {
            items = retrieveDataObject()
            print(#function, "Retrieved ITEMS from document directory: \(String(describing: dataModelURL))")
            items.forEach { print("\n", $0) }

            /// This is actually for iOS devices
//            refreshImageUrls(for: &items)
        }
 
    /// Adds an item to the data collection
    func addItem(_ item: Item) {
        items.insert(item, at: 0)
        storeDataObject(items)
    }
    
    /// Removes an item from the data collection
    func removeItem(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            FileManager.default.removeFileFromDocumentDirectory(url: item.imageURL)
        }
        storeDataObject(items)
    }
    
    /// Deletes items from data collection and urls from document directory
    func removeAllItems() {
        if let documentDirectory = FileManager.default.documentDirectory {
            let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage }
            
            for url in urls {
                FileManager.default.removeFileFromDocumentDirectory(url: url)
            }
            print("URLs DELETING FROM DOCUMENT DIRECTORY: \(urls)")
        }
        items.removeAll()
        storeDataObject(items) /// Refreshes data collection to zero
//        clearDataModel() /// Delete dataModel.data file
    }
}
