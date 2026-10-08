//
//  SettingsView.swift
//  Little-things
//
//  Created by Алексей Езерский on 03.04.2025.
//
//  Aespa-iOS
//
//  Created by Young Bin on 2023/06/08.
//

import SwiftUI
import AVFoundation

struct SettingView: View {
    @ObservedObject var viewModel: VideoContentViewModel

    @State private var quality: AVCaptureSession.Preset
    @State private var focusMode: AVCaptureDevice.FocusMode
    @State private var isMuted: Bool
    @State private var flashMode: AVCaptureDevice.FlashMode
    @AppStorage("iPadPortrait") var iPadPortrait: Bool = false
    
    init(contentViewModel viewModel: VideoContentViewModel) {
        self.viewModel = viewModel
        
        self.quality = viewModel.aespaSession.avCaptureSession.sessionPreset
        self.focusMode = viewModel.aespaSession.currentFocusMode ?? .continuousAutoFocus
        
        self.isMuted = viewModel.aespaSession.isMuted
        
        self.flashMode = viewModel.aespaSession.currentSetting.flashMode
    }
    
    var body: some View {
        Text("Настройки камеры")
            .font(.title3).foregroundStyle(.secondary).bold()
            .padding(.top, 10)
        List {
            Section(header: Text("Общие")) {
                Picker("Качество", selection: $quality) {
                    Text("Низкое").tag(AVCaptureSession.Preset.low)
                    Text("Среднее").tag(AVCaptureSession.Preset.medium)
                    Text("Высокое").tag(AVCaptureSession.Preset.high)
                }
                .modifier(TitledPicker(title: "Качество съёмки"))
                .onChange(of: quality) { _, newValue in
                    viewModel.aespaSession.common(.quality(preset: newValue))
                }
                
                Picker("Фокус", selection: $focusMode) {
                    Text("Авто").tag(AVCaptureDevice.FocusMode.autoFocus)
                    Text("Блокирован").tag(AVCaptureDevice.FocusMode.locked)
                    Text("Непрерывно").tag(AVCaptureDevice.FocusMode.continuousAutoFocus)
                }
                .modifier(TitledPicker(title: "Режим фокуса"))
                .onChange(of: focusMode) { _, newValue in
                    viewModel.aespaSession.common(.focus(mode: newValue))
                }
                Picker("Ориентация камеры iPad", selection: $iPadPortrait) {
                    Text("Горизонтально").tag(false)
                    Text("Вертикально").tag(true)
                }
                .modifier(TitledPicker(title: "Ориентация камеры iPad"))
                .onChange(of: iPadPortrait) { _, newValue in
                    viewModel.aespaSession.common(.orientation(orientation: iPadDevice ? newValue ? .portrait: .landscapeRight : .portrait))
                }
                .disabled(!iPadDevice)
            }
            
            Section(header: Text("Видео")) {
                Picker("Звук", selection: $isMuted) {
                    Text("Включен").tag(false)
                    Text("Отключен").tag(true)
                }
                .modifier(TitledPicker(title: "Звук"))
                .onChange(of: isMuted) { _, newValue in
                    viewModel.aespaSession.video(newValue ? .mute : .unmute)
                }
            }
            
            Section(header: Text("Фото")) {
                Picker("Вспышка", selection: $flashMode) {
                    Text("Включен").tag(AVCaptureDevice.FlashMode.on)
                    Text("Отключен").tag(AVCaptureDevice.FlashMode.off)
                    Text("Авто").tag(AVCaptureDevice.FlashMode.auto)
                }
                .modifier(TitledPicker(title: "Режим вспышки"))
                .onChange(of: flashMode) { _, newValue in
                    viewModel.aespaSession.photo(.flashMode(mode: newValue))
                }
            }
        }
    }
    
    struct TitledPicker: ViewModifier {
        let title: String
        func body(content: Content) -> some View {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.gray)
                    .font(.caption)
                
                content
                    .pickerStyle(.segmented)
                    .frame(height: 40)
            }
        }
    }
}
