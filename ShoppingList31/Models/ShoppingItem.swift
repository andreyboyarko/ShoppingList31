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
    let isSelected: Bool
    
    init(name: String, count: Int, isSelected: Bool = false) {
        self.name = name
        self.count = count
        self.isSelected = isSelected
    }
}

extension ShoppingItem {
    
    static let mock = ShoppingItem(
        name: "Молоко",
        count: 2,
        isSelected: true
    )
    
    static let mockArray = [
        ShoppingItem(name: "Хлеб", count: 1, isSelected: false),
        ShoppingItem(name: "Яйца", count: 10, isSelected: true),
        ShoppingItem(name: "Сыр", count: 1, isSelected: false),
        ShoppingItem(name: "Кофе", count: 1, isSelected: true),
        ShoppingItem(name: "Фрукты", count: 5, isSelected: false)
    ]
}
