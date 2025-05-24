//
//  imageListModeView.swift
//  Little-things
//
//  Created by Алексей Езерский on 27.01.2025.
//

import SwiftUI

extension ImageList {
    
    var imageListModeView: some View {
        List(selection: $selection) {
            ForEach(dataModel.items) { item in
                HStack{
                    NavigationLink(destination: DetailImageView(item: item).environmentObject(dataModel)) {
                        SelectedFileView(size: 85, url: item.imageURL)
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
    }
}
