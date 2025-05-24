//
//  DeleteButton.swift
//  Little-things
//
//  Created by Алексей Езерский on 08.01.2025.
//

import SwiftUI

//MARK: - Remove all items
struct DeleteButton: View {
    let allObjects: Bool
    var action: () -> Void = {}
    @State private var isRemove = false
    
    var body: some View {
        
        Button { withAnimation {isRemove = true}
        } label: {Image(systemName: "trash")}
        
        .actionSheet(isPresented: $isRemove) {
            ActionSheet(
                title: Text(!allObjects ? "Удалить отмеченные объекты?" : "Удалить все объекты?"),
                message: Text("Это действие нельзя отменить!"),
                buttons: [
                    .destructive(Text("Хорошо"), action: action),
                    .cancel(Text("Отменить"))
                ]
            )
        }
    }
}
