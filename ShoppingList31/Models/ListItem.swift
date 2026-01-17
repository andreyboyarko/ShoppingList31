//
//  ListCell.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/8/26.
//
import Foundation

struct ListItem: Identifiable {
    let id: UUID = UUID()
    let color: IconColor
    let icon: Icon
    let title: String
    let completed: Int
    let total: Int
    
    init (color: IconColor, icon: Icon, title: String, completed: Int, total: Int) {
        self.color = color
        self.icon = icon
        self.title = title
        self.completed = completed
        self.total = total
    }
}

extension ListItem {
    static let mock = ListItem(
        color: IconColor.blue,
        icon: Icon.calendarNumber,
        title: "Новый год",
        completed: 10,
        total: 20
    )
    
    static let mockArray = [
        ListItem(
            color: IconColor.blue,
            icon: Icon.calendarNumber,
            title: "Новый год",
            completed: 10,
            total: 20
        ),
        ListItem(
            color: IconColor.green,
            icon: Icon.paw,
            title: "Кошке",
            completed: 1,
            total: 4
        ),
        ListItem(
            color: IconColor.yellow,
            icon: Icon.gameController,
            title: "Вечеринка малого",
            completed: 9,
            total: 20
        )
    ]
}
