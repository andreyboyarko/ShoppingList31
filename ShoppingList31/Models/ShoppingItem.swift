//
//  ShoppingItem.swift
//  ShoppingList31
//
//  Created by Владимир on 02.01.2026.
//

import Foundation

struct ShoppingItem: Identifiable {
    let id = UUID()
    let name: String
    let count: Int
    let unit: String
    let isPurchased: Bool
    
    init(name: String, count: Int, unit: String, isSelected: Bool = false) {
        self.name = name
        self.count = count
        self.unit = unit
        self.isPurchased = isSelected
    }
}

extension ShoppingItem {
    
    static let mock = ShoppingItem(
        name: "Молоко",
        count: 2,
        unit: "л",
        isSelected: true
    )
    
    static let mockArray = [
        ShoppingItem(name: "Хлеб", count: 1, unit: "шт", isSelected: false),
        ShoppingItem(name: "Яйца", count: 10, unit: "шт", isSelected: true),
        ShoppingItem(name: "Сыр", count: 1, unit: "кг", isSelected: false),
        ShoppingItem(name: "Кофе", count: 1, unit: "кг", isSelected: true),
        ShoppingItem(name: "Фрукты", count: 5, unit: "кг", isSelected: false)
    ]
}
