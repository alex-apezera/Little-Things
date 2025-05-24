//
//  LaunchScreen.swift
//  Little-things
//
//  Created by Алексей Езерский on 24.01.2025.
//

import SwiftUI
///Greetings messsge with transition to icon image and start TabSelection
struct LaunchScreen: View {
    @Binding var startApp: Bool
    @State private var startLaunch: Bool = false
    let fs: CGFloat = iPadDevice ? 20 : 16

    var body: some View {
        
        Image("launchScreen")
            .ignoresSafeArea(.all)
        
            .onTapGesture {withAnimation {startLaunch = true}}
        
            .overlay {
                if startLaunch {
                    VStack {
                        VStack(alignment: .center, spacing: 5) {
                            Text(String.launchInfo)
                            Text(String.launchInfo1)
                            Text(String.launchInfo2)
                            if #available(iOS 17.0, *) {
                                Text(String.launchInfo3)
                                Text(String.launchInfo4)
                            }
                            Text(String.launchInfoSaved)
                                .padding(.top, 5)
                        }.padding(20)
                    }
                    .font(.system(size: fs, weight: .light, design: .rounded))
                    .foregroundStyle(.primary)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                    .background(.thickMaterial)
//                    .shadow(radius: 5)
                    .cornerRadius(10)
                    
                    .onTapGesture {withAnimation {startApp = true}}
                }
            }
    }
}

extension String {
    static let launchInfo: Self = "Добавляйте фото и видео в галерею"
    static let launchInfo1: Self = "Управляйте галереей"
    static let launchInfo2: Self = "Редактируйте название, цену, описание"
    static let launchInfo3: Self = "Перемещайте объекты в избранное"
    static let launchInfo4: Self = "Сортируйте объекты по названию или цене"
    static let launchInfoSaved: Self = "Все свойства сохраняются автоматически"
    
}
