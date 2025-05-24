//
//  ProductsList.swift
//  Little-things
//
//  Created by Алексей Езерский on 10.01.2025.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct ProductsList: View {
    @EnvironmentObject var dataModel: DataModel
    @AppStorage("favoritesIsEdit") var favoritesIsEdit: Bool = false
    @State var addFavorites: Bool = false
    @State var deleteFavorites: Bool = false
    
    @State var favoritesListMode: Bool = true
    @State var selection: Set<String> = []
    @State var editMode: EditMode = .inactive
    
    @AppStorage("productsCount") var productsCount: Int = 0
    @AppStorage("lastUpdatedProduct")
    var lastUpdatedProduct = Date.distantFuture.timeIntervalSince1970

    @Environment(\.modelContext) var modelContext
    
    @State var sortByName: Bool = true
    typealias Element = Object
    typealias Value = String
    static var keyByName: KeyPath<Element, Value> { \Object.name }
    static var keyByPrice: KeyPath<Element, Value> { \Object.price }
    @Query(sort: keyByName, order: .forward, animation: .smooth) var products: [Object]
    @Query(sort: keyByPrice, order: .forward, animation: .smooth) var productsByPrice: [Object]
    var objects: [Object] { sortByName ? products : productsByPrice }

    @AppStorage("initialColumnsFavorite") static var initialColumns = 3
    @State var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns
    private var columnsTitle: String {
        let count = gridColumns.count
        switch count {
        case 1: return "1 Колонка"
        case 2...4: return "\(count) Колонки"
        case 5...8: return "\(count) Колонок"
        default: return "\(count) Колонки"
        }
    }
    var title: String {
        if editMode == .inactive || selection.isEmpty {
            return "Избранное"
        } else {
            return "Выбрано: \(selection.count)"
        }
    }
    var body: some View {
        VStack {
            if favoritesListMode {
                productListMode
            } else {
                if favoritesIsEdit {
                    ColumnStepper(title: columnsTitle, range: 1...8, columns: $gridColumns).padding(5)
                }
                productGridMode
            }
        }
        .onAppear {
            restoreProductsFromDataModel
            productsCount = productsCounter
        }
        .environment(\.editMode, $editMode)
        .listStyle(.inset)
        .toolbar{productsToolbar}
    }
}
