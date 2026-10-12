//
//  isMacOs.swift
//  Little-things
//
//  Created by Алексей Езерский on 12.10.2026.
//

import Foundation

var isMacDesignedForIPad: Bool {
    #if targetEnvironment(macCatalyst)
    return true
    #else
    return ProcessInfo.processInfo.isiOSAppOnMac
    #endif
}
