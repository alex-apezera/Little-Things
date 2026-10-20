//
//  SelectedImageView.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import SwiftUI

/// Show an image from url
///
struct SelectedImageView: View {
    let size: Double
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(width: size, height: size)
    }
}
