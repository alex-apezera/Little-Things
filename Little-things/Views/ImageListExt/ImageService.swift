//
//  ImageService.swift
//  Little-things
//
//  Created by Алексей Езерский on 25.01.2025.
//

import SwiftUI

extension ImageList {
    
    /// Delete url object from Gallery directory and update Data model.
    ///
    func deleteImageObjects(at offsets: IndexSet) {
        var imageObjects = dataModel.items
        for index in offsets {
            let imageURL = imageObjects[index].imageURL
            FileManager.default.removeFileFromDocumentDirectory(url: imageURL) /// Delete selected object URL
        }
        imageObjects.remove(atOffsets: offsets)
        storeDataObject(imageObjects)
        dataModel.items = retrieveDataObject() /// Refresh DataModel
    }
    
    /// Delete objects by index.
    ///
    func deleteImageObjects(for codes: Set<String>) {
        let imageObjects = dataModel.items
        var offsetsToDelete: IndexSet = []
        for (index, element) in imageObjects.enumerated() {
            if codes.contains(element.id) {
                offsetsToDelete.insert(index)
            }
        }
        deleteImageObjects(at: offsetsToDelete)
        selection.removeAll()
    }
    
    /// Move objects by index.
    ///
    func moveImageObjects(source: IndexSet, destination: Int) {
        var imageObjects = dataModel.items
        imageObjects.move(fromOffsets: source, toOffset: destination)
        storeDataObject(imageObjects)
        dataModel.items = retrieveDataObject()/// Refresh DataModel
    }
}
