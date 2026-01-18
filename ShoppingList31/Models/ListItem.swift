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
    
    init (color: IconColor, icon: Icon, title: String, completed: Int, total: Int) {
        self.color = color
        self.icon = icon
        self.title = title
        self.completed = completed
        self.total = total
    }
}

extension ListItem {
    @MainActor
    static func makeMock(context: ModelContext) -> ListItem {
        let item = ListItem(
            color: .blue,
            icon: .calendarNumber,
            title: "Новый год",
            completed: 10,
            total: 20
        )
        context.insert(item)
        return item
    }
    
    static func makeMockArray(context: ModelContext) -> [ListItem] {
        let items = [
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
        
        items.forEach { context.insert($0) }
        return items
    }
    
}
