//
//  DetailProductView.swift
//  Little-things
//
//  Created by Алексей Езерский on 22.01.2025.
//

import SwiftUI
@available(iOS 17.0, *)
struct DetailProductView: View {
    let item: Object
    @State var products: [Object]
    
    @State private var editName: Bool = false
    @State private var editPrice: Bool = false
    @State private var editDescription: Bool = false

    var body: some View {
        VStack {
            if let index = products.firstIndex(of: item) {
                GeometryReader { geo in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(products) { item in
                                if item.name == products[index].name {
                                    GesturedPhotoView(size: geo.size.width*scaleOfPhoto, url: item.imageURL).imageCellModifier()
                                }
                            }
                        }
                    }
                }.padding(5)
                VStack {
                    ObjectDescription(isPresented: $editName, property: $products[index].name, title: "Название", prompt: "Введите название", font: iPadDevice ? .title3 : .body).padding(.bottom, 5)
                    
                    ObjectDescription(isPresented: $editPrice, property: $products[index].price, title: "Цена", prompt: "Введите цену", font: iPadDevice ? .body : .caption).padding(.bottom, 10)
                    
                    ObjectDescription(isPresented: $editDescription, property: $products[index].specification, title: "Oписание", prompt: "Введите описание", font: iPadDevice ? .body : .caption).padding(.bottom, 20)
                }
            }
        }
        .padding(.horizontal, 10)
        .navigationModifier("Избранное")
    }
}

