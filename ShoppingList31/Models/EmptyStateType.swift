//
//  EmptyStateType.swift
//  ShoppingList31
//
//  Created by Владимир on 28.12.2025.
//

import DeveloperToolsSupport

/// Перечисление состояний пустого экрана в приложении.
/// Используется для отображения соответствующих сообщений и изображений
/// когда в интерфейсе нет данных для показа.
///
/// При создании EmptyStateView выбирай:
/// createShoppingList если нужна заглушка для экран - "Главный экран - не создан список"
/// addItemToShoppingList если нужна заглушка для экрана - "Перечень товаров"

enum EmptyStateType {
    case createShoppingList
    case addItemToShoppingList
    
    static let title = "Давайте спланируем покупки!"
    
    var subtitle: String {
        switch self {
        case .createShoppingList:
            "Создайте свой первый список"
        case .addItemToShoppingList:
            "Начните добавлять товары"
        }
    }
    
    var imageResource: ImageResource {
        switch self {
        case .createShoppingList:
                .work
        case .addItemToShoppingList:
                .shopping
        }
    }
}
