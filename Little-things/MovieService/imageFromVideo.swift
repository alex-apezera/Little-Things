//
//  imageFromVideo.swift
//  Little-things
//
//  Created by Алексей Езерский on 11.04.2025.
//

import SwiftUI
import AVFoundation

/// Convert video frame to uiimage.
///
/// Make sure to call this from background queue
public func imageFromVideo(url: URL, at time: TimeInterval) async throws -> UIImage? {
    let asset = AVURLAsset(url: url)
    let generator = AVAssetImageGenerator(asset: asset)
    generator.appliesPreferredTrackTransform = true
    generator.apertureMode = .encodedPixels

    let cmTime = CMTime(seconds: time, preferredTimescale: 600)
    let (cgImage, _) = try await generator.image(at: cmTime)
    return UIImage(cgImage: cgImage)
}
