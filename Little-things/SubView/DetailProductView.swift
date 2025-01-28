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
    @EnvironmentObject var dataModel: DataModel
    
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
                                if let indexOfFavorite = dataModel.items.firstIndex(where: { $0.id == item.id }) {
                                    if item.name == products[index].name &&
                                        dataModel.items[indexOfFavorite].isFavorite {
                                        DetailFileView(size: geo.size.width*scaleOfPhoto, url: item.imageURL).imageCellModifier()
                                    }
                                }
                            }
                        }
                    }
                }.padding(5)
                VStack {
                    SimpleDescription(property: products[index].name, title: "Название", font: iPadDevice ? .title3 : .body).padding(.bottom, 5)
                    
                    SimpleDescription(property: products[index].price, title: "Цена", font: iPadDevice ? .body : .caption).padding(.bottom, 10)
                    
                    SimpleDescription(property: products[index].specification, title: "Oписание", font: iPadDevice ? .body : .caption).padding(.bottom, 20)
                }
            }
        }
        .padding(.horizontal, 10)
        .navigationModifier("Избранное")
    }
}

