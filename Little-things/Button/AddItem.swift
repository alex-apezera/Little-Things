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
    @AppStorage("addProduct") var addProduct: Bool = false
    @AppStorage("indexToAddProduct") var indexToAddProduct: Int?

    var body: some View {
        Button {
            addProduct = true
            tabSelected = 1
            indexToAddProduct = index
        } label: {
            Image(systemName: "arrowshape.right.fill")
                .font(Font.title2)
                .foregroundStyle(.blue)
        }
    }
}
