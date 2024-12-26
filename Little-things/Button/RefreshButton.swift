//
//  RefreshButton.swift
//  Little-things
//
//  Created by Алексей Езерский on 14.01.2025.
//

import SwiftUI

//MARK: - Remove all items
struct RefreshButton: View {
    @State private var isRefreshAll = false
    @EnvironmentObject private var dataModel: DataModel
    
    var body: some View {
        Button { withAnimation {isRefreshAll = true}
        } label: {
            Image(systemName: "arrow.counterclockwise")
        }
        .actionSheet(isPresented: $isRefreshAll) {
            ActionSheet(
                title: Text("Обновить данные?"),
                message: Text("Для удаления всех элементов нажмите на 'Trash'"),
                buttons:[
                    .destructive(Text("Обновить"), action: refreshData),
                    .cancel(Text("Отменить"))
                ]
            )
        }.disabled(dataModel.items.isEmpty)
    }
    
    func refreshData() {
        storeDataObject(dataModel.items)
    }
}
