//
//  getImagesData.swift
//  Little-things
//
//  Created by Алексей Езерский on 10.04.2025.
//

import SwiftUI
import PhotosUI

extension ImageList {

    /// Fetches metadata of  picked items (photos or videos)  from a photolibrary.
    ///
    /// This method provides name, creation date, address for each item.
    ///
    /// - Parameter:
    /// Array of picked items, called from `PhotosPicker`.
    func getImagesData(from newItems: [PhotosPickerItem]) async throws {
  
        for item in newItems {
            
            /// Default (initial) MataData value with initiation id value
            let id = randomString(length: idLength)
            var metaData = Item(id: id, name: "Не задано", price: "00:00", specification: "Нет данных", imageURL: URL(fileURLWithPath: ""), isFavorite: false)
            
            /// Get MetaData asset from PhotoLibrary
            selectedItem = item
            if let newItem = selectedItem, let localID = newItem.itemIdentifier {
                let result = PHAsset.fetchAssets(withLocalIdentifiers: [localID], options: nil)
                
                ///for debugging
                /*
                if let asset = result.firstObject {
                    print(#function, "GOT ASSET: " + asset.debugDescription)
                }
                 */
                
                /// Date of captuting photo
                if let imageDate = result.firstObject?.creationDate {
                    metaData.price = dateString(for: imageDate)
                }
                /// Get Coordinate if exist
                if let coordinate  = result.firstObject?.location?.coordinate {
                    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    // Placemark
                    location.placemark { placemark, error in
                        guard let placemark else { print("\n", #function, error ?? "Placemark not defined"); return }
                        // Title and Address of Place
                        metaData.name = placemark.name ?? ""
                        metaData.specification = placemark.streetName ?? ""
                        metaData.specification += " \(placemark.streetNumber ?? "")"
                        metaData.specification += " \(placemark.city ?? "")"
                        metaData.specification += " \(placemark.neighborhood ?? "")"
                        metaData.specification += " \(placemark.state ?? "")"
                        metaData.specification += " \(placemark.zipCode ?? "")"
                        metaData.specification += " \(placemark.country ?? "")"
                    }
                }
            }
            /// URL for store Image & video
            guard let documentDirectory = FileManager().documentDirectory else {return}
            copyFile = documentDirectory.appendingPathComponent("\(metaData.id)")

            /// Try import images or videos from Photolibrary depending on item
            if let photo = try? await item.loadTransferable(type: Photo.self) {
                metaData.imageURL = photo.url
            }
            if let movie = try? await item.loadTransferable(type: Movie.self) {
                metaData.imageURL = movie.url
            }
            // Insert reseived or default metadata to array of items
            withAnimation {
                dataModel.addItem(metaData)
            }
        } /// end for item...
    }

    
}
