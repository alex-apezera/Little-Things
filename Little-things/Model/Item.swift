//
//  Item.swift
//  Little-things
//
//  Created by Алексей Езерский on 30.12.2024.
//

import SwiftUI

struct Item: Identifiable, Codable {

    var id: String
    var name: String
    var price: String
    var specification: String
    var imageURL: URL
    var isFavorite: Bool
    
/* // See func getImageData
    init(id: String, name: String, price: String, specification: String, imageURL: URL) {
        self.id = id
        self.name = "Не задано"
        self.price = "00:00"
        self.specification = "Нет данных"
        self.imageURL = URL(fileURLWithPath: "")
    }
 */
}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
