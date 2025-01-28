//
//  Product.swift
//  Little-things
//
//  Created by Алексей Езерский on 10.01.2025.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
@Model
final class Object: Identifiable {
    @Attribute(.unique)
    var id: String  /* = UUID().uuidString */
    var name: String
    var price: String
    var specification: String
    var imageURL: URL
    
    init(id: String, name: String, price: String, specification: String, imageURL: URL) {
        self.id = id
        self.name = name
        self.price = price
        self.specification = specification
        self.imageURL = imageURL
    }
}
