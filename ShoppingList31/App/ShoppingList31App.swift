//
//  ShoppingList31App.swift
//  ShoppingList31
//
//  Created by Nikita Tsomuk on 21.12.2025.
//

import SwiftUI

@main
struct ShoppingList31App: App {
    @AppStorage("app_theme")
    private var storedTheme: AppTheme = .system
    
    @State private var themeStore = ThemeStore()
    
    init() {
        _themeStore = State(initialValue: ThemeStore(theme: storedTheme))
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen(lists: ListItem.mockArray)
                .onChange(of: themeStore.theme, { oldValue, newValue in
                    storedTheme = newValue
                })
                .preferredColorScheme(colorScheme(for: themeStore.theme))
                .environment(themeStore)
        }
    }
}

extension ShoppingList31App {
    private func colorScheme(for theme: AppTheme) -> ColorScheme? {
        switch theme {
        case .system: return nil
        case .light:  return .light
        case .dark:   return .dark
        }
    }
}
