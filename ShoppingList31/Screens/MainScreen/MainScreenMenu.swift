//
//  ContextMenuButton.swift
//  ShoppingList31
//
//  Created by Sultan Akhmetbek on 13.01.2026.
//

import SwiftUI

struct MainScreenMenu: View {
    @Environment(ThemeStore.self) var themeStore
    let sortAlphabetically: () -> Void
    
    var body: some View {
        Image(systemName: "ellipsis.circle")
            .padding(12)
            .contentShape(Rectangle())
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
            themeStore.theme = theme
        } label: {
            HStack {
                if themeStore.theme == theme {
                    Image(systemName: "checkmark")
                }
                Text(theme.rawValue)
            }
        }
    }
}

#Preview {
    let store = ThemeStore()
    
    MainScreenMenu(sortAlphabetically: {
        
    })
    .environment(store)
}
