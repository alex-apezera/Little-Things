//
//  TabSelection.swift
//  Little-things
//
//  Created by Алексей Езерский on 26.12.2024.
//

import SwiftUI

///Main view with menu selection in `TabView`
///
struct TabSelection: View {
                   
    @AppStorage("tabSelected") var tabSelected = 0
    @AppStorage("productsCount") var productsCount: Int = 0
    @StateObject var dataModel = DataModel()
    
    var body: some View {
        
        TabView(selection: $tabSelected) {
            
            NavigationView {
                ImageList().environmentObject(dataModel)
            }
            .badge(dataModel.items.count)
            .tabItem { Label("Галерея", systemImage: "photo.on.rectangle") }
            .tag(0)
            
            NavigationView {
                ProductsView().environmentObject(dataModel)
            }
            .badge(productsCount)
            .tabItem { Label("Избранное", systemImage: "star.square.on.square") }
            .tag(1)
            
            NavigationView {
                Settings()
            }
            .tabItem { Label(Settings().title, systemImage: "gear") }
            .tag(2)
        }
        .navigationModifier("Главное меню")
    }
}
