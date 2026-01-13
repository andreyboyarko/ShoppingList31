//
//  ContextMenuButton.swift
//  ShoppingList31
//
//  Created by Sultan Akhmetbek on 13.01.2026.
//

import SwiftUI


enum AppTheme: String, CaseIterable {
    case light = "Светлая"
    case dark = "Темная"
    case system = "Системная"
}

struct ContextMenuButton: View {
    let currentTheme: AppTheme
    let setTheme: (AppTheme) -> Void
    let sortAlphabetically: () -> Void
    
    var body: some View {
        Image(systemName: "ellipsis.circle")
            .contextMenu {
                Menu {
                    ForEach(AppTheme.allCases, id: \.self) { theme in
                        themeButton(theme)
                    }

                } label: {
                    Label("Установить тему", systemImage: "circle.lefthalf.filled.inverse")
                }

                Button {
                    sortAlphabetically()
                } label: {
                    Label("Сортировка по Алфавиту", systemImage: "arrow.up.arrow.down")
                }
            }

        
    }
    
    private func themeButton(_ theme: AppTheme) -> some View {
        Button {
            setTheme(theme)
        } label: {
            Label(theme.rawValue, systemImage: currentTheme == theme ? "checkmark" : "")
        }
    }
}

#Preview {
    ContextMenuButton(currentTheme: .dark, setTheme: { _ in
        
    }, sortAlphabetically: {
        
    })
}
