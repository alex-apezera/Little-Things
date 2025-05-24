//
//  VideoContentView.swift
//  Little-things
//
//  Created by Алексей Езерский on 03.04.2025.
//

import Aespa
import SwiftUI

enum AssetType {
    case video
    case photo
}

struct VideoContentView: View {
    @State var isRecording = false
    @State var isFront = false
    
    @State var showSetting = false
    @State var showGallery = false
    
    @State var captureMode: AssetType = .video
    
    @StateObject var viewModel = VideoContentViewModel()
    @EnvironmentObject var dataModel: DataModel
    
    @State var isCameraOff: Bool = false
    @AppStorage("tabSelected") var tabSelected = 0
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        
        ZStack {
            //Camera preview
            VStack {
                if isCameraOff {EmptyView()}
                else {viewModel.preview}
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity)
            VStack {
                // Video content buttons:
                ZStack(alignment: .center) {
                    captureModeToggle
                    settingsButton
                }
                Spacer()
                
                // Bottom buttons:
                HStack {
                    albumButton
                    Spacer()
                    recordingButton
                    Spacer()
                    cameraPositionButton
                }
            }
        }///ZStack
        .sheet(isPresented: $showSetting) {
            SettingView(contentViewModel: viewModel)
        }
        .sheet(isPresented: $showGallery) {
            GalleryView(mediaType: $captureMode, contentViewModel: viewModel)
                .environmentObject(dataModel)
        }
        .navigationModifier(isCameraOff ? "Камера выключена" : "Режим видео- и фотосъёмки")
        .toolbar { videoToolbar }
        .cameraOff
        .onChange(of: tabSelected) { _ in
            dismiss()
        }
    }
}

