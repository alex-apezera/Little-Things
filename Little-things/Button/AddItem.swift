//
//  AddItem.swift
//  Little-things
//
//  Created by Алексей Езерский on 18.01.2025.
//

import SwiftUI

//MARK: - Delete item
@available(iOS 17.0, *)
struct AddItem: View {
    let index: Int
    @AppStorage("tabSelected") var tabSelected = 0
    @AppStorage("addProductToObjects") var addProductToObjects: Bool = false
    @AppStorage("indexToAddProduct") var indexToAddProduct: Int?

    var body: some View {
        Button {
            addProductToObjects = true
            tabSelected = 1
            indexToAddProduct = index
        } label: {
            Image(systemName: "arrowshape.right.fill")
                .font(Font.title2)
                .foregroundStyle(.blue)
        }
    }
}
