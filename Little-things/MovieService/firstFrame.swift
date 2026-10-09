//
//  firstFrame.swift
//  Little-things
//
//  Created by Алексей Езерский on 11.04.2025.
//

import SwiftUI

/// Use this as to call image in Gallery
@ViewBuilder
public func firstFrame(_ size: CGFloat, _ movie: URL) -> some View {
    FirstFrameView(size: size, movie: movie)
}

public struct FirstFrameView: View {
    let size: CGFloat
    let movie: URL

    @State private var uiImage: UIImage?
    @State private var duration: String = ""

    public var body: some View {
        Group {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 3)
                    .overlay(alignment: .bottomLeading) {
                        if !duration.isEmpty {
                            Text(duration)
                                .font(.caption2)
                                .background(.black)
                                .foregroundStyle(.white)
                                .offset(x: 3, y: -3)
                        }
                    }
            } else {
                // Placeholder while the image loads
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: size, height: size)
                    .cornerRadius(8)
            }
        }
        .task {
            do {
                if let img = try await imageFromVideo(url: movie, at: 0) {
                    uiImage = img
                }
                duration = try await getVideoDuration(from: movie)
            } catch {
                print("Ошибка извлечения первого кадра из видео",error)
                uiImage = UIImage(systemName: "video.square.fill")
            }
        }
    }
}

/// Separated small view for the duration
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
