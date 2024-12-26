//
//  RefreshUrls.swift
//  Little-things
//
//  Created by Алексей Езерский on 27.01.2025.
//

import Foundation

func refreshImageUrls(for items: inout [Item]) {
    if let documentDirectory = FileManager.default.documentDirectory {
        print("\n", #function, "DOCUMENT DIRECTORY: \(documentDirectory)")
        let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage }
        
        for url in urls {
            if let index = items.firstIndex(where: {$0.imageURL.lastPathComponent == url.lastPathComponent}) {
                items[index].imageURL = url
            } else {
                print(#function, "NOT FOUND INDEX, URL: \(url)\n")
            }
        }
    }
}
@available(iOS 17.0, *)
func refreshObjectUrls(for items: [Object]) {
    if let documentDirectory = FileManager.default.documentDirectory {
        print("\n", #function, "DOCUMENT DIRECTORY: \(documentDirectory)")
        let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage }
        
        for url in urls {
            if let index = items.firstIndex(where: {$0.imageURL.lastPathComponent == url.lastPathComponent}) {
                items[index].imageURL = url
            } else {
                print(#function, "NOT FOUND INDEX, URL: \(url)\n")
            }
        }
    }
}
