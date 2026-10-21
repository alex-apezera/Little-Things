//
//  itemImport.swift
//  Little-things
//
//  Created by Алексей Езерский on 21.10.2026.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers

extension Item {

    /// Данные для экспорта: все String-поля кроме id + файл по imageURL.
    ///
    /// Возвращает массив NSItemProvider, готовых к передаче в UIActivityViewController.
    func makeImportProviders() -> [NSItemProvider] {
        var providers: [NSItemProvider] = []

        // 1) Текстовые поля (все String, кроме id)
        /*
        let text = """
        \\(name)
        \\(price)
        \\(specification)
        """
         */

        // Каждое поле отдельным провайдером — так принимающие приложения
        // (Notes, Mail, iMessage) корректно разложат текст.
        providers.append(NSItemProvider(object: name as NSString))
        providers.append(NSItemProvider(object: price as NSString))
        providers.append(NSItemProvider(object: specification as NSString))
        // Плюс общий текстовый блок для приложений, ожидающих один payload
//        providers.append(NSItemProvider(object: text as NSString))

        // 2) Файл (фото или видео) по imageURL
        // UTType определяется по расширению/содержимому — .image или .movie
        if let type = UTType(filenameExtension: imageURL.pathExtension) {
            let provider: NSItemProvider

            if type.conforms(to: .movie) {
                // Видео: передаём как файл, чтобы воспроизводилось со звуком
                // в системном плеере (AVPlayer).
                provider = NSItemProvider(contentsOf: imageURL) ?? NSItemProvider()
                provider.suggestedName = imageURL.lastPathComponent

                provider.registerFileRepresentation(
                    forTypeIdentifier: type.identifier,
                    fileOptions: [],
                    visibility: .all
                ) { completion in
                    completion(self.imageURL, true, nil)
                    return nil
                }
            } else if type.conforms(to: .image) {
                // Фото: передаём как файл изображения
                provider = NSItemProvider(contentsOf: imageURL) ?? NSItemProvider()
                provider.suggestedName = imageURL.lastPathComponent

                provider.registerFileRepresentation(
                    forTypeIdentifier: type.identifier,
                    fileOptions: [],
                    visibility: .all
                ) { completion in
                    completion(self.imageURL, true, nil)
                    return nil
                }
            } else {
                // Неизвестный тип — пробуем как есть
                provider = NSItemProvider(contentsOf: imageURL) ?? NSItemProvider()
            }

            providers.append(provider)
        }

        return providers
    }
}
