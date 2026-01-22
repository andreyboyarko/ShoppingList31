//
//  ShoppingItem.swift
//  ShoppingList31
//
//  Created by Владимир on 02.01.2026.
//

import Foundation
import SwiftData

@Model
final class ShoppingItem: Identifiable {
    @Attribute(.unique) var id = UUID()
    var name: String
    var count: Int
    var unit: String
    var isPurchased: Bool
    var list: ListItem?
    var createdAt: Date = Date()
    
    init(name: String, count: Int, unit: String, isSelected: Bool = false, list: ListItem) {
        self.name = name
        self.count = count
        self.unit = unit
        self.isPurchased = isSelected
        self.list = list
    }
}

extension Array where Element == ShoppingItem {
    var shareText: String {
        map { "\($0.name) - \($0.count) \($0.unit)" }.joined(separator: "\n")
    }
}
