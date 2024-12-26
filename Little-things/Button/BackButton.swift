//
//  BackButton.swift
//  Little-things
//
//  Created by Алексей Езерский on 31.12.2024.
//

import SwiftUI

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
