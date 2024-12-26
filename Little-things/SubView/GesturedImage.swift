//
//  GesturedImage.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 11.11.2023.

//MARK: - Gesture experience with image

import SwiftUI

struct GesturedImage: View {
    let image: Image
    @Environment(\.dismiss) private var dismiss
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isActive: Bool {
            switch self {
            case .inactive:
                return false
            case .pressing, .dragging:
                return true
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive, .pressing:
                return false
            case .dragging:
                return true
            }
        }
    }
    
    @GestureState private var dragState = DragState.inactive
    @State private var viewState = CGSize.zero
    @State private var scale = 1.0
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    
    var tap: some Gesture {
        TapGesture()
            .onEnded { _ in
                withAnimation {
                    scale += 0.5
                }
            }
    }
    var doubleTap: some Gesture {
        TapGesture(count: 2)
            .onEnded { _ in
                withAnimation {
                    scale -= 0.1
                }
            }
    }
    var zoom: some Gesture {
        if #available(iOS 17.0, *) {
            return MagnifyGesture()
                .onChanged { value in
                    currentZoom = value.magnification - 1
                }
                .onEnded { value in
                    totalZoom += currentZoom
                    currentZoom = 0
                }
        } else {
            return TapGesture()
                .onEnded { _ in
                    withAnimation {
                        scale += 0.8
                    }
                }
        }
    }
    
    var body: some View {
        let minimumLongPressDuration = 0.5
        let longPressDrag = LongPressGesture(minimumDuration: minimumLongPressDuration)
            .sequenced(before: DragGesture())
            .updating($dragState) { value, state, transaction in
                switch value {
                    // Long press begins.
                case .first(true):
                    state = .pressing
                    // Long press confirmed, dragging may begin.
                case .second(true, let drag):
                    state = .dragging(translation: drag?.translation ?? .zero)
                    // Dragging ended or the long press cancelled.
                default:
                    state = .inactive
                }
            }
            .onEnded { value in
                guard case .second(true, let drag?) = value else { return }
                self.viewState.width += drag.translation.width
                self.viewState.height += drag.translation.height
            }
        ZStack {
            image
                .resizable()
                .scaledToFit()
                .overlay(dragState.isDragging ? Rectangle().stroke(Color.white, lineWidth: 2) : nil)
                .scaleEffect(scale)
                .offset(
                    x: viewState.width + dragState.translation.width,
                    y: viewState.height + dragState.translation.height
                )
                .shadow(radius: dragState.isActive ? 8 : 0)
                .animation(.linear(duration: minimumLongPressDuration), value: 0)
                .gesture(doubleTap)
                .gesture(tap)
                .gesture(longPressDrag)
                .scaleEffect(currentZoom + totalZoom)
                .gesture(zoom)
                .accessibilityZoomAction { action in
                    if action.direction == .zoomIn {
                        totalZoom += 1
                    } else {
                        totalZoom -= 1
                    }
                }
            VStack(alignment: .trailing) {
                HStack(alignment: .top) {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(Font.title2)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .red)
                    }
                }
                Spacer()
            }
        }
    }
}
