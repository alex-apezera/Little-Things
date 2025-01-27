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
    
    @AppStorage("favoritesListMode") var favoritesListMode: Bool = false
    @State var selection: Set<String> = []
    @State var editMode: EditMode = .inactive
    
    @AppStorage("addProductToObjects") var addProductToObjects: Bool = false
    @AppStorage("indexToAddProduct") var indexAddProduct: Int?
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

    private static var initialColumns = 3
    @State var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns
    private var columnsTitle: String {
        gridColumns.count > 1 ? "\(gridColumns.count) Колонок" : "1 Колонка"
    }
    
    var title: String {
        if editMode == .inactive || selection.isEmpty {
            return "Избранные: \(objects.count)"
        } else {
            return "\(selection.count) выбрано"
        }
    }

    var body: some View {
        
        VStack {
            
            if sortByName {
                if !products.isEmpty {Text("Отсортировано по названию").font(.caption)}
            } else {
                if !products.isEmpty {Text("Отсортировано по возрастанию в цене").font(.caption)}
            }
            
            if favoritesListMode {
                productListMode
            } else {
                if favoritesIsEdit {
                    ColumnStepper(title: columnsTitle, range: 1...8, columns: $gridColumns).padding(5)
                }
                productGridMode
            }
        }
        .onAppear {refreshObjectUrls(for: objects)}
        .onAppear {
            if let indexAddProduct, addProductToObjects {
                addProductFromDataModel(for: indexAddProduct)
            }
            addProductToObjects = false
        }
        .onChange(of: objects)  { newValue in
            productsCount = newValue.count
            lastUpdatedProduct = Date().timeIntervalSince1970
        }
        .toolbar { productsToolbar() }
        .environment(\.editMode, $editMode)
        .listStyle(.inset)
        .navigationModifier(title)
    }
}
