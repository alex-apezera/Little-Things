//
//  MoviePlay.swift
//  Little-things
//
//  Created by Алексей Езерский on 11.04.2025.
//

import SwiftUI
import AVKit

//MARK: - VideoPlayer

struct MoviePlay: View {
    
    let size: CGFloat
    let url: URL
    @State private var isFullScreen: Bool = false
    
    var body: some View {
        VideoPlayer(player: AVPlayer(url: url))
            .frame(maxWidth: size, maxHeight: size)
            .overlay(alignment: .topLeading) {
                icon("arrow.up.left.and.arrow.down.right")
                    .onTapGesture { withAnimation { isFullScreen = true } }
            }
            .fullScreenCover(isPresented: $isFullScreen) {
                VideoPlayer(player: AVPlayer(url: url))
                    .overlay(alignment: .topLeading) {
                        icon("arrow.down.right.and.arrow.up.left")
                            .onTapGesture { withAnimation { isFullScreen = false } }
                    }
            }
    }
    
    private func icon(_ iconName: String) -> some View {
        Image(systemName: iconName)
            .frame(width: 40, height: 40)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .foregroundStyle(.white).opacity(0.8)
            .padding(10)
            .offset(x: iPadDevice ? 0 : 25, y: iPadDevice ? 55: 0)
    }
}

