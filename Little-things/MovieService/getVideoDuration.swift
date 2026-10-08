//
//  getVideoDuration.swift
//  Little-things
//
//  Created by Алексей Езерский on 11.04.2025.
//

import AVFoundation

/// video duration stamp on firstFrame
public func getVideoDuration(from path: URL) async throws -> String {
    let asset = AVURLAsset(url: path)
    let duration: CMTime = try await asset.load(.duration)

    let totalSeconds = CMTimeGetSeconds(duration)
    let hours = Int(totalSeconds / 3600)
    let minutes = Int((totalSeconds.truncatingRemainder(dividingBy: 3600)) / 60)
    let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))

    if hours > 0 {
        return String(format: "%i:%02i:%02i", hours, minutes, seconds)
    } else if !(minutes == 0 && seconds == 0) {
        return String(format: "%02i:%02i", minutes, seconds)
    } else {
        return ""
    }
}
