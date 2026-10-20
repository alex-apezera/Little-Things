//
//  RefreshUrls.swift
//  Little-things
//
//  Created by Алексей Езерский on 27.01.2025.
//

import Foundation

/// Refresh the gallery file urls in the document directory
///
func refreshImageUrls(for items: inout [Item]) {
    guard let documentDirectory = FileManager.default.documentDirectory else { return }
    let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { [$0.isImage, $0.isVideo].contains(true) }
    
    for url in urls {
        if let index = items.firstIndex(where: {$0.imageURL.lastPathComponent == url.lastPathComponent}) {
            items[index].imageURL = url
            print(#function, "Founded INDEX: \(index); URL: \(url)\n")
        } else {
            print(#function, "NOT FOUND INDEX, URL: \(url)\n")
        }
    }
}

/// Refresh the favorite file urls in the document directory
///
@available(iOS 17.0, *)
func refreshObjectUrls(for items: [Object]) {
    //    if let documentDirectory = FileManager.default.documentDirectory {
    guard let documentDirectory = FileManager.default.documentDirectory else { return }
    let urls =  FileManager.default.getContentsOfDirectory(documentDirectory).filter { [$0.isImage, $0.isVideo].contains(true) }
    
    for url in urls {
        if let index = items.firstIndex(where: {$0.imageURL.lastPathComponent == url.lastPathComponent}) {
            items[index].imageURL = url
            print(#function, "Founded INDEX: \(index); URL: \(url)\n")
        } else {
            print(#function, "NOT FOUND INDEX, URL: \(url)\n")
        }
    }
    //    }
}
