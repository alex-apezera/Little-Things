//
//  ImageList.swift
//  Little-things
//
//  Created by Алексей Езерский on 29.12.2024.
//

import SwiftUI
import PhotosUI

/// Gallery view of media files with associated data model items
struct ImageList: View {
    @EnvironmentObject var dataModel: DataModel
    @AppStorage("isEditing") var isEditing = false
    @State var selection: Set<String> = []
    @State var editMode: EditMode = .inactive
    @State var selectedItems: [PhotosPickerItem] = []
    @State var selectedItem: PhotosPickerItem?
    @State var isLoading: Bool = false

    @AppStorage("listMode") var listMode: Bool = false
    @AppStorage("tabSelected") var tabSelected = 0
    @AppStorage("enableVideo") var enableVideo = false
    @AppStorage("onlyPhotoSelection") var onlyPhotoSelection = true
    @AppStorage("copyFile") var copyFile: URL = URL(fileURLWithPath: "")
    
    @AppStorage("lastUpdatedObject")
    var lastUpdatedObject = /*Date().timeIntervalSince1970*/
        Date.distantFuture.timeIntervalSince1970
    @AppStorage("lastUpdatedProduct")
    var lastUpdatedProduct = Date.distantFuture.timeIntervalSince1970
    
    @AppStorage("initialColumns") static var initialColumns = 3
    @State var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns
    private var columnsTitle: String {
        let count = gridColumns.count
        switch count {
        case 1: return "1 Колонка"
        case 2...4: return "\(count) Колонки"
        case 5...8: return "\(count) Колонок"
        default: return "\(count) Колоноки"
        }
    }

    var title: String {
        if editMode == .inactive || selection.isEmpty {
            return "Галерея"
        } else {
            return "Выбрано: \(selection.count)"
        }
    }

    var body: some View {
        VStack {
            
            if listMode {
                imageListModeView
            } else {
                if isEditing {
                    ColumnStepper(title: columnsTitle, range: 1...8, columns: $gridColumns).padding(5)
                }
                imageGridModeView
            }
        }
        .onChange(of: selectedItems) { _, newItems in ///Get & store data from items
            storeImagesData(newItems)
        }
        .refreshable {storeDataObject(dataModel.items)}
        .toolbar {imageListToolbar}
        .environment(\.editMode, $editMode)
        .listStyle(.inset)
        .navigationModifier(title)
    }
}
