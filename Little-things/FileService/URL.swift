//
//  URL.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import SwiftUI

extension URL {
    
    static var dataModel = FileManager.default.documentDirectory?.appendingPathComponent("dataModel.data")

    // Convert and store uiimage to URL
    func saveUIImage(_ uiimage: UIImage?) async {
        if let uiimage {
            if let data = uiimage.jpegData(compressionQuality: 1.0) {
                try? data.write(to: self)
            }
        } else {
            print(#function, "UIImage is nil, so removing file \(self)")
            try? FileManager.default.removeItem(at: self)
        }
    }
    
    // Retrieve uiimage from URL
    func loadUIImage(_ uiimage: inout UIImage?) {
        if let data = try? Data(contentsOf: self), let loaded = UIImage(data: data) {
            uiimage = loaded
        } else {
            print(#function, "Couldn't load UIImage from URL: \(self)")
            uiimage = nil
        }
    }
    
    // Indicates whether the URL has a file extension corresponding to a common image format. Use in Image Gallery.
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }

}
