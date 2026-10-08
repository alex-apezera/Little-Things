//
//  firstFrame.swift
//  Little-things
//
//  Created by Алексей Езерский on 11.04.2025.
//

import SwiftUI

/// use this as to call image
@ViewBuilder
public func firstFrame(_ size: CGFloat, _ movie: URL) -> some View {
    if let uiimage = imageFromVideo(url: movie, at: 0) {
        let image = Image(uiImage: uiimage)
        image.resizable(capInsets: .init(), resizingMode: .stretch)
            .frame(width: size, height: size)
            .cornerRadius(8)
            .scaledToFit()
            .shadow(radius: 3)
            .overlay(alignment: .bottomLeading) {
                VideoDurationOverlay(movie: movie)
                    .font(.caption2)
                    .background(.thinMaterial)
                    .foregroundStyle(.white)
                    .offset(x: 3, y: -3)
                    .underline(false)
            }
    }
}

/// Separated view for the duration
private struct VideoDurationOverlay: View {
    let movie: URL
    @State private var duration: String = ""

    var body: some View {
        Text(duration)
            .task {
                do {
                    duration = try await getVideoDuration(from: movie)
                } catch {
                    duration = ""
                }
            }
    }
}
