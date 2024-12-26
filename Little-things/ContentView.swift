//
//  ContentView.swift
//  Little-things
//
//  Created by Алексей Езерский on 26.12.2024.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("tabSelected") var tabSelected = 0
    @AppStorage("productsCount") var productsCount: Int = 0
    @StateObject var dataModel = DataModel()
    
    var body: some View {
        
        TabView(selection: $tabSelected) {
            
            NavigationView {
                ImageList().environmentObject(dataModel)
            }
            .badge(dataModel.items.count)
            .tabItem { Label("Галерея", systemImage: "photo") }
            .tag(0)
            
            if #available(iOS 17.0, *) {
                NavigationView {
                    ProductsView().environmentObject(dataModel)
                    
                }
                .badge(productsCount)
                .tabItem { Label("Избранное", systemImage: "rectangle.grid.3x2") }
                .tag(1)
            }
            
            NavigationView {
                Settings(title: "Настройки")
            }
            .badge("1")
            .tabItem { Label("Настройки", systemImage: "gear") }
            .tag(2)
        }
        .navigationModifier("Главное меню")
    }
}
