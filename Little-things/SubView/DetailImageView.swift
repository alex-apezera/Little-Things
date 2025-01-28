//
//  DetailImageView.swift
//  Little-things
//
//  Created by Алексей Езерский on 06.01.2025.
//

import SwiftUI

struct DetailImageView: View {
    @State var item: Item
    @EnvironmentObject var dataModel: DataModel
    
    @State private var editName: Bool = false
    @State private var editPrice: Bool = false
    @State private var editDescription: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            if let index = dataModel.items.firstIndex(where: {$0.id == item.id}) {
                GeometryReader { geo in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(dataModel.items) { item in
                                if item.name == dataModel.items[index].name {
                                    DetailFileView(size: geo.size.width*scaleOfPhoto, url: item.imageURL).imageCellModifier()
                                }
                            }
                        }
                    }
                }
                .padding(5)
                VStack {
                    ObjectDescription(isPresented: $editName, property: $dataModel.items[index].name, title: "Название", prompt: "Введите название", font: iPadDevice ? .title3 : .body).padding(.bottom, 5)
                        .onChange(of: dataModel.items[index].name) { _ in
                            storeDataObject(dataModel.items)
                        }
                    ObjectDescription(isPresented: $editPrice, property: $dataModel.items[index].price, title: "Цена", prompt: "Введите цену", font: iPadDevice ? .body : .caption).padding(.bottom, 10)
                        .onChange(of: dataModel.items[index].price) { _ in
                            storeDataObject(dataModel.items)
                        }
                    ObjectDescription(isPresented: $editDescription, property: $dataModel.items[index].specification, title: "Oписание", prompt: "Введите описание", font: iPadDevice ? .body : .caption).padding(.bottom, 20)
                        .onChange(of: dataModel.items[index].specification) { _ in
                            storeDataObject(dataModel.items)
                        }
                }
            }
        }
        .padding(.horizontal, 10)
        .navigationModifier("Фото + Описание")
    }
}
