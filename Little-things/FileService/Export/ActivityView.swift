//
//  ActivityView.swift
//  Little-things
//
//  Created by Алексей Езерский on 21.10.2026.
//

import SwiftUI
import UIKit

/// UIActivityViewController, открываемый из SwiftUI.
///
struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems,
                                 applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: Context) {}
}
