//
//  ListCell.swift
//  ShoppingList31
//
//  Created by Волошин Александр on 1/8/26.
//
import Foundation

struct ListItem: Identifiable {
    let id: UUID = UUID()
    let color: String
    let icon: String
    let title: String
    let completed: Int
    let total: Int
    
    init (color: String, icon: String, title: String, completed: Int, total: Int) {
        self.color = color
        self.icon = icon
        self.title = title
        self.completed = completed
        self.total = total
    }
}

extension ListItem {
    static let mock = ListItem(
        color: "IconBlue",
        icon: "calendar-number",
        title: "Новый год",
        completed: 10,
        total: 20
    )
    
    static let mockArray = [
        ListItem(
            color: "IconBlue",
            icon: "calendar-number",
            title: "Новый год",
            completed: 10,
            total: 20
        ),
        ListItem(
            color: "IconGreen",
            icon: "paw",
            title: "Кошке",
            completed: 1,
            total: 4
        ),
        ListItem(
            color: "IconBlue",
            icon: "calendar-number",
            title: "Новый год",
            completed: 10,
            total: 20
        ),
        ListItem(
            color: "IconBlue",
            icon: "calendar-number",
            title: "Новый год",
            completed: 10,
            total: 20
        ),
        ListItem(
            color: "IconBlue",
            icon: "calendar-number",
            title: "Новый год",
            completed: 10,
            total: 20
        ),
        ListItem(
            color: "IconBlue",
            icon: "calendar-number",
            title: "Новый год",
            completed: 10,
            total: 20
        ),
        ListItem(
            color: "IconBlue",
            icon: "calendar-number",
            title: "Новый год",
            completed: 10,
            total: 20
        ),
        ListItem(
            color: "IconBlue",
            icon: "calendar-number",
            title: "Новый год",
            completed: 10,
            total: 20
        ),
        ListItem(
            color: "IconYellow",
            icon: "game-controller",
            title: "Вечеринка малого",
            completed: 9,
            total: 20
        )
    ]
}
