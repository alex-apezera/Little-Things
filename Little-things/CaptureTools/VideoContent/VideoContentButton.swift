//
//  VideoContentButton.swift
//  Little-things
//
//  Created by Алексей Езерский on 24.05.2025.
//

import SwiftUI
extension VideoContentView {
    
    /// Capture mode toggle
    ///
    var captureModeToggle: some View {
        Picker("Режим съёмки", selection: $captureMode) {
            Text("Видео").tag(AssetType.video)
            Text("Фото").tag(AssetType.photo)
        }
        .pickerStyle(.segmented)
        .background(.thinMaterial)
        .cornerRadius(8)
        .frame(width: 200)
    }
    
    ///Calls settings view for media options
    ///
    var settingsButton: some View {
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
    
    /// Album thumbnail + button
    ///
    var albumButton: some View {
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
    }
    
    /// Camera position change + button
    ///
    var cameraPositionButton: some View {
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
    
    /// Shutter + button
    ///
    var recordingButton: some View {
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
