//
//  ImageManager.swift
//  Little-things
//
//  Created by Алексей Езерский on 05.01.2025.
//  Edited 09.04.2025

import PhotosUI

class ImageManager: NSObject {
    
    ///Как сохранить изображения в библиотеке фотографий пользователя
    ///Пол Хадсон @twostraws 11 декабря 2023 года (hackingwithswift.com)
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error {
            print(#function, error)
        } else {
            print(#function, "Save Image to Photos Library finished!")
        }
    }
    
///https://stackoverflow.com/questions/75983606/delete-photo-after-selection
    
    func deleteItemFromLibrary(assetIdentifier: String) {
        
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: [assetIdentifier], options: nil)
        guard let asset = fetchResult.firstObject else { return }
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.deleteAssets([asset] as NSArray)
        } completionHandler: { success, error in
            if success {
                print("Image deleted from photo library")
            } else {
                print("Error deleting image from photo library: \(error?.localizedDescription ?? "unknown error")")
            }
        }
    }

}
