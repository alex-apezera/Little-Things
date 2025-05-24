//
//  Little_thingsApp.swift
//  Little-things
//
//  Created by Алексей Езерский on 26.12.2024.
//

import SwiftUI

///Length of randomized string in file names and id's
///
let idLength: Int = 8

///Global property which checks device is it iPad (or iPhone)
///
///It is `true` when device is iPad, and `false` otherwise
///
let iPadDevice: Bool = UIDevice.current.userInterfaceIdiom == .pad

///Scales an image in `Detail Views` on `NavigationLink` screen
///
var scaleOfPhoto = iPadDevice ? 0.6 : 0.85

///App localized for `Russian`
///
///It selects photo or video from user Photos library with metadata and allows its to play and to edit metadata.
///It also includes the ability capture video/photo, and (later iOS 17) mark its favorites.
@main
struct Little_thingsApp: App {
    @State var startApp: Bool = false
    var body: some Scene {
        WindowGroup {
            if startApp {
                TabSelection()
            }
            else { LaunchScreen(startApp: $startApp) }
        }
    }
}

/// Useful snipped for localization.
/// (don't work in this App)

//@State var localeRu: Bool = true

//let localeEnglish = "en"
//let localeRussian = "ru"

//    .environment(\.locale, .init(identifier: localeRu ? localeRussian : localeEnglish))

