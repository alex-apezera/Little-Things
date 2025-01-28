//
//  productSortButton.swift
//  Little-things
//
//  Created by Алексей Езерский on 24.05.2025.
//

import SwiftUI

@available(iOS 17.0, *)
extension ProductsList {
    
    var productSortButton: some View {
        
        Button {
            withAnimation {sortByName.toggle()}
        } label: {
            Image(systemName: sortByName ? "rublesign" : "character")
        }
        .disabled(objects.isEmpty)
    }
}
