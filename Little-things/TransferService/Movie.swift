//
//  Movie.swift
//  Little-things
//
//  Created by Алексей Езерский on 10.04.2025.
//

import SwiftUI

struct Movie: Transferable {
    let url: URL

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { received in
            Self.init(url: copyTransferredFile(received))
        }
    }
}

