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
    @AppStorage("didShowOnboarding") private var didShowOnboarding = false
    @AppStorage("app_theme") private var storedTheme: AppTheme = .system
    
    @State private var themeStore = ThemeStore()
    
    init() {
        _themeStore = State(initialValue: ThemeStore(theme: storedTheme))
    }
    
    var body: some Scene {
        WindowGroup {
            if didShowOnboarding {
                MainScreen()
                    .withRouter()
                    .onChange(of: themeStore.theme, { _, newValue in
                        storedTheme = newValue
                    })
                    .preferredColorScheme(colorScheme(for: themeStore.theme))
                    .environment(themeStore)
                    .modelContainer(for: [ListItem.self, ShoppingItem.self])
            } else {
                WelcomeView {
                    didShowOnboarding = true
                }
            }
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
