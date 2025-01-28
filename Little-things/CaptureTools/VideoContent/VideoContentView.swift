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
    
    @StateObject private var viewModel = VideoContentViewModel()
    @EnvironmentObject var dataModel: DataModel
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("jpegCompression") var jpegCompression: Double  = 1.0
    @State var isCameraOff: Bool = false
    @AppStorage("tabSelected") var tabSelected = 0
    
    var body: some View {
        
        ZStack {
            VStack {
                if isCameraOff {EmptyView()}
                else {viewModel.preview}
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity)
            VStack {
                ZStack(alignment: .center) {
                    
                    // Capture mode
                    Picker("Режим съёмки", selection: $captureMode) {
                        Text("Видео").tag(AssetType.video)
                        Text("Фото").tag(AssetType.photo)
                    }
                    .pickerStyle(.segmented)
                    .background(.thinMaterial)
                    .cornerRadius(8)
                    .frame(width: 200)
                    
                    // Settings
                    HStack {
                        Spacer()
                        Button(action: { showSetting = true }) {
                            Image(systemName: "gear")
                                .resizable()
                                .foregroundColor(.white)
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .padding(20)
                        .contentShape(Rectangle())
                    }
                }
                Spacer()
                
                // Bottom buttons
                ZStack {
                    HStack {
                        // Album thumbnail + button
                        Button(action: { showGallery = true }) {
                            let coverImage = (
                                captureMode == .video
                                ? viewModel.videoAlbumCover
                                : viewModel.photoAlbumCover)
                            ?? Image("sc-camera")
                            roundRectangleShape(with: coverImage, size: 80)
                        }
                        .shadow(radius: 5)
                        .contentShape(Rectangle())
                        
                        Spacer()
                        
                        // Camera position change + button
                        Button(action: {
                            viewModel.aespaSession.common(.position(position: isFront ? .back : .front))
                            isFront.toggle()
                        }) {
                            Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(20)
                                .padding(.trailing, 20)
                        }
                        .shadow(radius: 5)
                        .contentShape(Rectangle())
                    }
                    
                    // Shutter + button
                    recordingButtonShape(width: 60).onTapGesture {
                        switch captureMode {
                        case .video:
                            if isRecording {
                                viewModel.aespaSession.stopRecording() { result in
                                    switch result {
                                    case .success(let file):
                                        storeVideoToGallery(file: file)
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                                isRecording = false
                            } else {
                                viewModel.aespaSession.startRecording(autoVideoOrientationEnabled: true)
                                isRecording = true
                            }
                        case .photo:
                            viewModel.aespaSession.capturePhoto(autoVideoOrientationEnabled: true) { result in
                                switch result {
                                case .success(let photoFile):
                                    print("\n", "PHOTOFILE: ", photoFile.image as Any) // PhotoFile
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        }
                    }
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

