//
//  Item.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import SwiftUI

let idLength: Int = 8

struct Item: Identifiable, Codable {

    var id: String
    var name: String
    var price: String
    var specification: String
    var imageURL: URL
    
    init(id: String, name: String, price: String, specification: String, imageURL: URL) {
        self.id = id
        self.name = id
        self.price = "0.00"
        self.specification = ""
        self.imageURL = imageURL
    }
}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
