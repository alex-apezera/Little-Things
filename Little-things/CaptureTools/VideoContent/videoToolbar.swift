//
//  videoToolbar.swift
//  Little-things
//
//  Created by Алексей Езерский on 22.05.2025.
//


import SwiftUI
extension VideoContentView {
    
    /// Toggle Camera in off/on position
    ///
    /// - Note: Sometimes this action is useful for saving resources.
    ///
    @ToolbarContentBuilder
    var videoToolbar: some ToolbarContent {

        ToolbarItem(placement: .topBarTrailing) {
            Button {
                withAnimation {isCameraOff.toggle()}
                if isCameraOff {aespaOff()}
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        tabSelected = 0
                        ImageList().enableVideo = true
                        dismiss()})
                }
                    
            } label: {
                Image(systemName: isCameraOff ? "video" : "video.slash")
                    .foregroundStyle(isCameraOff ? .blue  : .green)
            }
        }
    }
}

