//
//  EmptyStateType.swift
//  ShoppingList31
//
//  Created by Владимир on 28.12.2025.
//

import DeveloperToolsSupport

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
