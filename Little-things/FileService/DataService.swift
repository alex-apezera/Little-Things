//
//  DataService.swift
//  Little-things
//
//  Created by Алексей Езерский on 08.01.2025.
//

import SwiftUI

// MARK: - DataModel store, retrieve, remove

func clearDataModel() {
    guard let dataModelURL = FileManager.dataModelURL else {return}
    do {
        try FileManager.default.removeItem(at: dataModelURL)
        print("\n", #function, "Successfully deleted stored DataModel file:", dataModelURL)
    } catch {
        print(#function, "Error deleting file DataModel: \(error)")
    }
}

func storeDataObject(_ dataObject: [Item]) {
    @AppStorage("lastUpdatedObject")
    var lastUpdatedObject = Date.distantFuture.timeIntervalSince1970
    guard let dataModelURL = FileManager.dataModelURL else {return}
    do {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(dataObject)
        // Save jsonData to a file
        try jsonData.write(to: dataModelURL)
        lastUpdatedObject = Date().timeIntervalSince1970
//        print("\n", #function, "dataObject:", dataObject)
    } catch {
        print(#function, "Error encoding data: \(error)")
    }
}

func retrieveDataObject() -> [Item] {
    var dataObject = [Item]()
    guard let dataModelURL = FileManager.dataModelURL else {return []}
    do {
        // Retrieve jsonData from the file using FileManager
        let jsonData = try Data(contentsOf: dataModelURL)
        let jsonDecoder = JSONDecoder()
        let readingData = try jsonDecoder.decode([Item].self, from: jsonData)
        dataObject = readingData
//        print("\n", #function, "dataObject:", dataObject, "\n")
    } catch {
        print(#function, "Error decoding data: \(error)")
    }
    return dataObject
}

