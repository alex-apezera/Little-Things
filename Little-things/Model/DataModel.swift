//
//  DataModel.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import Foundation

final class DataModel: ObservableObject {
    @Published var items: [Item] = []

    ///Recall initial state
    init() {
        items = retrieveDataObject()
        refreshImageUrls(for: &items)//Actually for iOS
    }
 
    /// Adds an item to the data collection
    func addItem(_ item: Item) {
        items.insert(item, at: 0)
        print("\n", #function, "Sucsesfully added item: \(item)", "\n")
        storeDataObject(items)///Refreshes data collection
    }
    
    /// Removes an item from the data collection
    func removeItem(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            FileManager.default.removeFileFromDocumentDirectory(url: item.imageURL)
        }
        print("\n", #function, "Sucsesfully removed item: \(item)", "\n")
        storeDataObject(items)///Refreshes data collection
    }
    
    /// Deletes items from data collection and urls from document directory
    func removeAllItems() {
        guard let documentDirectory = FileManager.default.documentDirectory else { return }
        let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { [$0.isImage, $0.isVideo].contains(true) }
            
            for url in urls {
                FileManager.default.removeFileFromDocumentDirectory(url: url)
            }
            print("URLs DELETED FROM DOCUMENT DIRECTORY: \(urls)")
//        }
        items.removeAll()
        clearDataModel() /// Delete dataModel.json file
    }
}
