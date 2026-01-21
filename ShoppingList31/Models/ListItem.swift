//
//  ListCell.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/8/26.
//
import Foundation
import SwiftData

@Model
final class ListItem {
    @Attribute(.unique) var id: UUID = UUID()
    var color: IconColor
    var icon: Icon
    var title: String
    var completed: Int
    var total: Int
    @Relationship(deleteRule: .cascade)
    var items: [ShoppingItem] = []
    
    init (color: IconColor, icon: Icon, title: String, completed: Int, total: Int, items: [ShoppingItem] = []) {
        self.color = color
        self.icon = icon
        self.title = title
        self.completed = completed
        self.total = total
        self.items = items
    }
}
