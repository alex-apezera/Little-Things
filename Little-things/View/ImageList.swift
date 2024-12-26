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
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
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
                List(selection: $selection) {
                    ForEach(dataModel.items) { item in
                        HStack{
                            NavigationLink(destination: DetailImageView(item: item).environmentObject(dataModel)) {
                                SelectedImageView(size: 80, url: item.imageURL)
                                    .imageGridModifier()
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name).bold()
                                    Text(item.price)
                                    Text(item.specification).foregroundStyle(.secondary)
                                }
                                .font(.system(size: 12))
                                .lineLimit(3)
                                .frame(height: 90)
                            }
                        }
                    }
                    .onDelete(perform: deleteImageObjects)
                    .onMove(perform: moveImageObjects)
                }
            } else {
                if isEditing {
                    ColumnStepper(title: columnsTitle, range: 1...8, columns: $gridColumns).padding(5)
                }

                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: gridColumns) {
                        ForEach(dataModel.items) { item in
                            if let index = dataModel.items.firstIndex(of: item) {
                                GeometryReader { geo in
                                    NavigationLink(destination: DetailImageView(item: item).environmentObject(dataModel)) {
                                        SelectedImageView(size: geo.size.width, url: item.imageURL)
                                    }
                                }
                                .imageGridModifier()
                                .overlay(alignment: .topTrailing) {
                                    if isEditing { DeleteItem() { dataModel.removeItem(item) } } }
                                .overlay(alignment: .bottomTrailing) {
                                    if #available(iOS 17.0, *), isEditing {
                                        AddItem(index: index)
                                    }
                                }
                            }///if
                        }///ForEach
                    }.padding(.top, 5)
                }.padding(.horizontal, 7)
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
