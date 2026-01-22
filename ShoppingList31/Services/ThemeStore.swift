//
//  AppTheme.swift
//  ShoppingList31
//
//  Created by Султан Ахметбек on 18.01.2026.
//

import Foundation
import SwiftUI

enum AppTheme: String, CaseIterable {
    case light = "Светлая"
    case dark = "Темная"
    case system = "Системная"
    
    var localizedName: String {
        String(localized: String.LocalizationValue(rawValue))
    }
}

@MainActor
@Observable
final class ThemeStore {
    var theme: AppTheme = .system
    
    init(theme: AppTheme = .system) {
        self.theme = theme
    }
}
