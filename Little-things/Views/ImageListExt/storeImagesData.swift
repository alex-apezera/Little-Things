//
//  storeImagesData.swift
//  Little-things
//
//  Created by Алексей Езерский on 11.04.2025.
//

import _PhotosUI_SwiftUI

extension ImageList {
    
    /// Metadata will gets from  Photolibrary and will stores in json file(s).
    ///
    /// - Parameter: array of `PhotosPicker` items.
    ///
    func storeImagesData(_ items: [PhotosPickerItem]) {
        Task {
            do {
                isLoading = true
                try await getImagesData(from: items)
                // Store MetaDataObject
                storeDataObject(dataModel.items)
                // Signal then loadind is completion
                isLoading = false
                // Elimination duplication when re-entering to PhotosPicker
                selectedItems.removeAll()
                // Refresh the date then loadind
                lastUpdatedObject = Date().timeIntervalSince1970
            } catch {
                print("\n", #function, "Error: \(error)")
            }
        }
    }
}
