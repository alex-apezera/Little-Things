//
//  Little_thingsApp.swift
//  Little-things
//
//  Created by Алексей Езерский on 26.12.2024.
//

import SwiftUI

//MARK: - Check device is iPad (or iPhone)
var iPadDevice: Bool { UIDevice.current.userInterfaceIdiom == .pad }
var scaleOfPhoto = iPadDevice ? 0.6 : 0.85

@main
struct Little_thingsApp: App {
    @State var startApp: Bool = false
    var body: some Scene {
        WindowGroup {
            if startApp { ContentView() }
            else { LaunchScreen(startApp: $startApp) }
        }
    }
}
