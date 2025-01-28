//
//  Photo.swift
//  Little-things
//
//  Created by Алексей Езерский on 10.04.2025.
//

import SwiftUI

struct Photo: Transferable {
    let url: URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .image) { photo in
            SentTransferredFile(photo.url)
        } importing: { received in
            Self.init(url: copyTransferredFile(received))
        }
    }
}
