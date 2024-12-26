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
    @State var isEditing = false
    @State var addProducts: Bool = false
    @State var deleteProducts: Bool = false
    @AppStorage("addProduct") var addProduct: Bool = false
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
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns
    private var columnsTitle: String {
        gridColumns.count > 1 ? "\(gridColumns.count) Колонок" : "1 Колонка"
    }
    
    private var title: String {
        "Товаров: \(products.count)"
    }
        
    var body: some View {
        
        VStack {
            if isEditing {
                ColumnStepper(title: columnsTitle, range: 1...8, columns: $gridColumns).padding(5)
            }
            if sortByName {
                if !products.isEmpty {Text("Отсортировано по названию").font(.caption)}
            } else {
                if !products.isEmpty {Text("Отсортировано по возрастанию в цене").font(.caption)}
            }
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: gridColumns) {
                    showProducts(objects)
                }.padding(.top, 5)
            }.padding(.horizontal, 7)
        }
        .onAppear {refreshObjectUrls(for: products)}
        .onAppear() {
            if let indexAddProduct, addProduct {
                addProductFromDataModel(for: indexAddProduct)
            }
            addProduct = false
        }
        .onChange(of: objects)  { newValue in
            productsCount = newValue.count
            lastUpdatedProduct = Date().timeIntervalSince1970
        }
        .toolbar { productsToolbar() }
        .navigationModifier(title)
    }
}
