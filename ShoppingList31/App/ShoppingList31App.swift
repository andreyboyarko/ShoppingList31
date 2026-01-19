//
//  ShoppingList31App.swift
//  ShoppingList31
//
//  Created by Nikita Tsomuk on 21.12.2025.
//

import SwiftUI
import SwiftData

@main
struct ShoppingList31App: App {
    var body: some Scene {
        WindowGroup {
            ShoppingItemList(navigationTitle: "Новый год")
        }
        .modelContainer(for: [ListItem.self, ShoppingItem.self])
    }
}
