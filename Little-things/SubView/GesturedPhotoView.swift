//
//  GesturedPhotoView.swift
//  Little-things
//
//  Created by Алексей Езерский on 24.01.2025.
//

import SwiftUI

struct GesturedPhotoView: View {
    let size: Double
    let url: URL
    @State private var isShowingImageViewer: Bool = false
    
    var body: some View {
        AsyncImage(url: url) { image in
            Button {
                isShowingImageViewer = true
//                GesturedImage(image: image)
            } label: {
                image.resizable()
                    .scaledToFill()
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            .fullScreenCover(isPresented: $isShowingImageViewer) {
                GesturedImage(image: image)
            }

        } placeholder: {
            ProgressView()
        }
        .frame(width: size, height: size)
    }
}
