//
//  FileManager.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import Foundation

extension FileManager {
    
    //MARK: - Path to store DataModel in FileManager
    static var dataModelURL: URL?  {
        let url = FileManager.default.documentDirectory?.appendingPathComponent("dataModel.json")
//        print("\n", #function, url ?? URL(string: "nil")!)
        return url
    }
    
    //MARK: - Create new folder for photo objects files

    static func getDocumentsDirectory() -> URL {
        let paths = self.default.urls(for: .documentDirectory, in: .userDomainMask)
//        print("\n", #function, paths.first!)
        return paths.first!
    }
        
    //MARK: - Property and methods for Image Gallery
    /// The URL of the document directory.
    var documentDirectory: URL? {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    /// Copies the specified file URL to a file with the same name in the document directory.
    ///
    /// - returns: The URL of the copied or existing file in the documents directory, or nil if the copy failed.
    ///
    func copyItemToDocumentDirectory(from sourceURL: URL, to fileName: String ) -> URL? {
        guard let documentDirectory else { return nil }
        let pathExtension = sourceURL.pathExtension
        let newFileName = "\(fileName).\(pathExtension)"
        let destinationURL = documentDirectory.appendingPathComponent(newFileName)
        if self.fileExists(atPath: destinationURL.path) {
            print(#function, "File already exists: ", destinationURL)
            return destinationURL
        } else {
            do {
                try self.copyItem(at: sourceURL, to: destinationURL)
                print("\n", #function, "Success copying file: ")
                print("\n", "sourceURL: ", sourceURL, "\n", "destinationURL: ", destinationURL)
                return destinationURL
            } catch let error {
                print(#function, "Unable to copy file: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    /// Create new image URL in the document directory.
    ///
    /// - returns: The URL of the created  file in the document directory or nil if the create failed.
    ///
    func createFileInDirectory(name: String) -> URL? {
        guard let documentDirectory else { return nil }
        let fileName = "\(name).jpeg"
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    /// Removes an item with the specified file URL from the document directory, if present.
    ///
    /// - parameter url: The file URL to be removed.
    ///
    func removeFileFromDocumentDirectory(url: URL) {
        guard let documentDirectory else { return }
        let fileName = url.lastPathComponent
        let fileUrl = documentDirectory.appendingPathComponent(fileName)
        if self.fileExists(atPath: fileUrl.path) {
            do {
                try self.removeItem(at: url)
                print("\n", #function, "Removed file: \(fileName)...")
            } catch let error {
                print(#function, "Unable to remove file: \(error.localizedDescription)")
            }
        }
    }
    
    /// Returns the contents of the specified directory as an array of URLs.
    func getContentsOfDirectory(_ url: URL) -> [URL] {
        var isDirectory: ObjCBool = false
        // The URL must be a directory.
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory), isDirectory.boolValue else { return [] }
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        } catch let error {
            print(#function, "Unable to get directory contents: \(error.localizedDescription)")
        }
        return []
    }
}

