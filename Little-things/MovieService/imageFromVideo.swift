//
//  imageFromVideo.swift
//  Little-things
//
//  Created by Алексей Езерский on 11.04.2025.
//

import SwiftUI
import AVFoundation

//MARK: - Convert video frame to uiimage
// make sure to call this from background queue
//public func imageFromVideo(url: URL, at time: TimeInterval) -> UIImage? {
//        
//    let asset = AVURLAsset(url: url)
//    
//    let assetIG = AVAssetImageGenerator(asset: asset)
//    assetIG.appliesPreferredTrackTransform = true
//    assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels
//    
//    let cmTime = CMTime(seconds: time, preferredTimescale: 60)
//    let thumbnailImageRef: CGImage
//    do {
//        thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
//    } catch let error {
//        print("Error: \(error)")
//        return UIImage(systemName: "video.square.fill")
//    }
//    return UIImage(cgImage: thumbnailImageRef)
//}

public func imageFromVideo(url: URL, at time: TimeInterval) async throws -> UIImage? {
    let asset = AVURLAsset(url: url)
    let generator = AVAssetImageGenerator(asset: asset)
    generator.appliesPreferredTrackTransform = true
    generator.apertureMode = .encodedPixels

    let cmTime = CMTime(seconds: time, preferredTimescale: 600)
    let (cgImage, _) = try await generator.image(at: cmTime)
    return UIImage(cgImage: cgImage)
}
