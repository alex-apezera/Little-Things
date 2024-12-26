//
//  SelectedImageView.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

//MARK: - Show image from url

import SwiftUI

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
