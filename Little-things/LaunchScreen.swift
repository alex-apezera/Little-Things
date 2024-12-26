//
//  LaunchScreen.swift
//  Little-things
//
//  Created by Алексей Езерский on 24.01.2025.
//

import SwiftUI

struct LaunchScreen: View {
    @Binding var startApp: Bool

    var body: some View {
        Image("launchScreen")
            .onTapGesture {
                startApp = true
            }
    }
}

//            .resizable().ignoresSafeArea().scaledToFill()
