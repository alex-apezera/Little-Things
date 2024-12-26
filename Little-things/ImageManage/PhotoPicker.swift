//
//  PhotoPicker.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import SwiftUI
import PhotosUI
import SwiftData

//@available(iOS 17.0, *)

struct PhotoPicker: UIViewControllerRepresentable {

    @EnvironmentObject var dataModel: DataModel
    @Environment(\.presentationMode) var presentationMode
    
    /// A dismiss action provided by the environment. This may be called to dismiss this view controller.
    @Environment(\.dismiss) var dismiss
    
    /// Creates the picker view controller that this object represents.
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> PHPickerViewController {
        
        /// Configure the picker.
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        /// Limit to images.
        configuration.filter = .images
        /// Avoid transcoding, if possible.
        configuration.preferredAssetRepresentationMode = .current
        
        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator
        return photoPickerViewController
    }
    
    /// Creates the coordinator that allows the picker to communicate back to this object.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /// Updates the picker while it’s being presented.
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<PhotoPicker>) {
        // No updates are necessary.
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        /// Called when one or more items have been picked, or when the picker has been canceled.
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            /// Dismisss the presented picker.
            self.parent.dismiss()
            parent.presentationMode.wrappedValue.dismiss()
            
            /// Outside:
//PhotoPicker.Coordinator(PhotoPicker()).parent.dismiss()
//PhotoPicker.Coordinator(PhotoPicker()).parent.presentationMode.wrappedValue.dismiss()

            
            // MARK: Fetch (and copy) Image Url from picked item
            guard
                let result = results.first,
                result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier)
            else { return }
                        
            /// Load a file representation of the picked item.
            /// This creates a temporary file which is then copied to the app’s document directory for persistent storage.
            result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                if let error {
                    print(#function, "Error loading file representation: \(error.localizedDescription)")
                } else if let url {
                        self.pickItemFromLibrary(from: url)
                }
            }
        }
        
        func pickItemFromLibrary(from url: URL) {
            let id = randomString(length: idLength)

            if let savedUrl = FileManager.default.copyItemToDocumentDirectory(from: url, to: id) {

            /// Add the new item to the data model.
                Task { @MainActor [dataModel = self.parent.dataModel] in
                    withAnimation(.spring(duration: 0.6, bounce: 0.4)) {
                        let item = Item(id: id, name: id, price: "0.00", specification: "", imageURL: savedUrl)
                        dataModel.addItem(item)
                        storeDataObject(dataModel.items)
                        print(#function, "ITEM = ", item)
                    }
                }
            }
        }
    }
}
