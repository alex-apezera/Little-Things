//
//  videoToolbar.swift
//  Little-things
//
//  Created by Алексей Езерский on 22.05.2025.
//


import SwiftUI
extension VideoContentView {
    
    ///Toggle Camera in off/on position
    ///
    /// - Note: Sometimes this action is useful for saving resources. This works correctly above iOS 17.0.
    ///
    @ToolbarContentBuilder
    var videoToolbar: some ToolbarContent {

        ToolbarItem(placement: .topBarTrailing) {
            Button {
                withAnimation {isCameraOff.toggle()}
                if isCameraOff {aespaOff()}
                else {
                    tabSelected = 2
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {tabSelected = 0; dismiss()})
                }
                    
            } label: {
                if #available(iOS 17, *) {
                    Image(systemName: isCameraOff ? "video" : "video.slash")
                        .foregroundStyle(isCameraOff ? iPadDevice ? .blue : .clear : .green)
                }
            }
        }
    }
}
