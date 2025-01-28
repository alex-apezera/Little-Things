//
//  MainView.swift
//  Little-things
//
//  Created by Алексей Езерский on 26.12.2024.
//

import SwiftUI
///Main view with menu selection in `TabView`
struct MainView: View {
    
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
            
            if #available(iOS 17.0, *) {
                NavigationView {
                    ProductsView().environmentObject(dataModel)
                }
                .badge(productsCount)
                .tabItem { Label("Избранное", systemImage: "star.square.on.square") }
                .tag(1)
            }
            
            NavigationView {
                Settings(title: "Настройки")
            }
            .badge("3")
            .tabItem { Label("Настройки", systemImage: "gear") }
            .tag(2)
        }
        .navigationModifier("Главное меню")
    }
}
