//
//  sortedMessage.swift
//  Little-things
//
//  Created by Алексей Езерский on 28.04.2025.
//

import SwiftUI

@available(iOS 17.0, *)
extension ProductsList {

    @ViewBuilder var sortedMessage: some View {
        VStack(alignment: .center) {
            if products.isEmpty {
                Text("Избранное")
            } else {
                Text("Отсортировано")
                if sortByName {
                    Text("по названию")
                }
                else {
                    Text("по ценe")
                }
            }
        }
        .font(.smallCaps(.caption)()).fontWeight(.heavy)
    }
}
