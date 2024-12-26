//
//  ProductsView.swift
//  Little-things
//
//  Created by Алексей Езерский on 10.01.2025.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct ProductsView: View {
    
    let modelContainer: ModelContainer
    
    init() {
        let config = ModelConfiguration(for: Object.self, isStoredInMemoryOnly: false)

        do {modelContainer = try ModelContainer(for: Object.self, configurations: config)}
        catch {fatalError("Could not initialize ModelContainer")}
    }
    
    var body: some View {
        ProductsList()
            .modelContainer(for: Object.self)
            .navigationModifier("Избранное")
    }
}
