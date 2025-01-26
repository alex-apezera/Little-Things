//
//  ImageList.swift
//  Little-things
//
//  Created by Алексей Езерский on 29.12.2024.
//

import SwiftUI

struct ImageList: View {
    @EnvironmentObject var dataModel: DataModel
    @AppStorage("isEditing") var isEditing = false
    @State var selection: Set<String> = []
    @State var editMode: EditMode = .inactive

    @AppStorage("listMode") var listMode: Bool = false
    @AppStorage("addProduct") var addProduct: Bool = false
    @AppStorage("indexToAddProduct") var indexToAddProduct: Int?
    @AppStorage("lastUpdatedObject")
    var lastUpdatedObject = /*Date().timeIntervalSince1970*/
        Date.distantFuture.timeIntervalSince1970
    
    private static var initialColumns = 3
    @State var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns
    private var columnsTitle: String {
        gridColumns.count > 1 ? "\(gridColumns.count) Колонок" : "1 Колонка"
    }
    
    var title: String {
        if editMode == .inactive || selection.isEmpty {
            return "Объектов: \(dataModel.items.count)"
        } else {
            return "\(selection.count) выбрано"
        }
    }

    var body: some View {
        VStack {
            
            if listMode {
                imageListMode
            } else {
                if isEditing {
                    ColumnStepper(title: columnsTitle, range: 1...8, columns: $gridColumns).padding(5)
                }
                imageGridMode
            }
        }
        .onAppear {refreshImageUrls(for: &dataModel.items)}
        .refreshable {storeDataObject(dataModel.items)}
        .toolbar {thingsToolbar()}
        .environment(\.editMode, $editMode)
        .listStyle(.inset)
        .navigationModifier(title)
    }
}
